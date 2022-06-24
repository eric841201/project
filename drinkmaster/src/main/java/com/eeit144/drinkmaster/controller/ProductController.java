package com.eeit144.drinkmaster.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eeit144.drinkmaster.bean.ProductBean;
import com.eeit144.drinkmaster.bean.ProductCategoryBean;
import com.eeit144.drinkmaster.bean.StoreBean;
import com.eeit144.drinkmaster.service.ProductCategoryServiceImp;
import com.eeit144.drinkmaster.service.ProductServiceImp;

@Controller
@Transactional
@RequestMapping("/backend")
public class ProductController {
	@Autowired
	private ProductServiceImp proService;
	@Autowired ProductCategoryServiceImp categoryService;

	@GetMapping("product/insertview")
	public String addView(Model m) {
		ProductBean pro = new ProductBean();
		m.addAttribute("now","新增商品");
		m.addAttribute("status","確定新增");
		List<ProductCategoryBean> productcategory1 =categoryService.findAll();
		m.addAttribute("productcategory1",productcategory1);
		m.addAttribute("product", pro);
		m.addAttribute("insert", "product/insert");
		return "backproductinsert";
	}
	@GetMapping ("productanalyze")
	public String analyzeview() {
		return "productanalyze";
	}
	@GetMapping("prodcuct/insertcategory")
	public String addCategoryView(Model m) {
		ProductCategoryBean category=new ProductCategoryBean();
		m.addAttribute("status","確定新增");
		m.addAttribute("now","新增種類");
		m.addAttribute("category",category);
		m.addAttribute("insert", "category/add");
		return "backproductcategoryinsert";
	}
	@PostMapping("/category/add")
	public String saveCategory(@ModelAttribute("category") ProductCategoryBean cate ) {
		categoryService.insertCategory(cate);
		
		return "redirect:/backend/category/all";
	} 
	@PostMapping("/product/insert")
	public String insertProduct(@RequestParam String productName, @RequestParam String price,
			@RequestParam String coldHot, @RequestParam Boolean status,
			@RequestParam ProductCategoryBean productCategoryBean,@RequestPart("productImage") MultipartFile productImage, Model m) throws IOException {
		Map<String, String> errors = new HashMap<String, String>();
		m.addAttribute("errors", errors);
		if (productName == null || productName.length() == 0) {
			errors.put("name", "請輸入品項");
		}
		if (price == null || price.length() == 0) {
			errors.put("price1", "請輸入正確金額");
		}
		if (price.length() != 0 && Integer.parseInt(price) < 0) {
			errors.put("price1", "請輸入正確金額");
		}

		if (errors != null && !errors.isEmpty()) {
			ProductBean pro = new ProductBean();
			m.addAttribute("product", pro);
			m.addAttribute("insert", "product/insert");
			return "backproductinsert";
		}

		ProductBean pro = new ProductBean();
		String filetype = productImage.getContentType();
		pro.setPrice(Integer.parseInt(price));
		pro.setColdHot(coldHot);
		pro.setStatus(status);
		pro.setProductName(productName);
		pro.setProductCategoryBean(productCategoryBean);

		String filebase64 = proService.getFileBase64String(productImage);
		String productimage = "data:" + filetype + ";base64," + filebase64 + "";
		System.out.println(productimage + "<--");
		if (productimage.equals("data:application/octet-stream;base64,")) {
			pro.setProductImage(null);
		} else {
			pro.setProductImage(productimage);
		}

		proService.insertProduct(pro);

		return "redirect:/backend/product/all";
	}

	@GetMapping("product/all")
	public ModelAndView findView(ModelAndView mav, @RequestParam(name = "p", defaultValue = "1") Integer pageNumber) {
		Page<ProductBean> page = proService.findByPage(pageNumber);
		mav.getModel().put("page", page);
		mav.setViewName("backproduct");
		return mav;
	}
	
	@GetMapping("category/all")
	public ModelAndView categoryView(ModelAndView mav, @RequestParam(name = "p", defaultValue = "1") Integer pageNumber) {
		Page<ProductCategoryBean> page = categoryService.findByPage(pageNumber);

		mav.getModel().put("page", page);
		mav.setViewName("backcategory");
		return mav;
	}

	@GetMapping("product/select")
	public ModelAndView selectLike(ModelAndView mav, @RequestParam(name = "p", defaultValue = "1") Integer pageNumber,
			@RequestParam("select") String select, @RequestParam("filed") String filed) {

		System.out.println(select);
		System.out.println(filed);
		if (filed.equals("上架中") || filed.equals("已下架")) {
			Page<ProductBean> page = proService.select(pageNumber, filed, filed);
			mav.getModel().put("page", page);
			mav.setViewName("backproduct");
			return mav;
		}
		Page<ProductBean> page = proService.select(pageNumber, select, filed);
		mav.getModel().put("page", page);
		mav.setViewName("backproduct");
		return mav;
	}@GetMapping("category/select")
	public ModelAndView selecCategorytLike(ModelAndView mav, @RequestParam(name = "p", defaultValue = "1") Integer pageNumber,
			@RequestParam("select") String select, @RequestParam("filed") String filed) {

		Page<ProductBean> page = categoryService.select(pageNumber, select, filed);
		mav.getModel().put("page", page);
		mav.setViewName("backcategory");
		return mav;
	}

	@GetMapping("deleteproduct")
	public String deleteById(@RequestParam("id") Integer id) {

		proService.deleteById(id);
		return "redirect:/backend/product/all";

	}
	@GetMapping("deletecategory")
	public String deleteCategoryById(@RequestParam("id") Integer id) {

		categoryService.deleteById(id);
		return "redirect:/backend/category/all";
}
	@GetMapping("editcategory")
	public String updateCategoryById(@RequestParam("id") Integer id, Model m) {
		ProductCategoryBean proBean = categoryService.findById(id);
		m.addAttribute("status","確定修改");
		m.addAttribute("now","修改種類");
		m.addAttribute("category", proBean);
		m.addAttribute("insert", "updatecategory");
		return "backproductcategoryinsert";
	}

	@GetMapping("editproduct")
	public String updateById(@RequestParam("id") Integer id, Model m) {
		ProductBean proBean = proService.findById(id);
		List<ProductCategoryBean> productcategory1 =categoryService.findAll();
		m.addAttribute("now","編輯商品");
		m.addAttribute("status","確定修改");
		m.addAttribute("productcategory1",productcategory1);
		m.addAttribute("product", proBean);
		m.addAttribute("insert", "updateproduct");
		return "backproductinsert";
	}
	@PostMapping("updatecategory")
	public String editCategory(@ModelAttribute("category") ProductCategoryBean cate ) {
		
		categoryService.insertCategory(cate);
		
		return "redirect:/backend/category/all";
	} 

	@PostMapping("updateproduct")
	public String postUpdate(@RequestParam Integer productId,@RequestParam ProductCategoryBean productCategoryName, @RequestParam String productName,
			@RequestParam String price, @RequestParam String coldHot, @RequestParam Boolean status,
			 @RequestPart("productImage") MultipartFile productImage, Model m)
			throws IOException {

		Map<String, String> errors = new HashMap<String, String>();
		m.addAttribute("errors", errors);
		if (productName == null || productName.length() == 0) {
			errors.put("name", "請輸入品項");
		}
		if (price == null || price.length() == 0) {
			errors.put("price1", "請輸入正確金額");
		}
		if (price.length() != 0 && Integer.parseInt(price) < 0) {
			errors.put("price1", "請輸入正確金額");
		}

		if (errors != null && !errors.isEmpty()) {
			ProductBean oldBean = proService.findById(productId);
			m.addAttribute("product", oldBean);
			m.addAttribute("insert", "updateproduct");
			return "backproductinsert";
		}
		ProductBean pro = new ProductBean();
		ProductBean oldBean = proService.findById(productId);
		pro.setProductId(productId);
		pro.setPrice(Integer.parseInt(price));
		pro.setColdHot(coldHot);
		pro.setStatus(status);
		pro.setProductName(productName);
		
		pro.setProductCategoryBean(productCategoryName);

		String filetype = productImage.getContentType();

		String filebase64 = proService.getFileBase64String(productImage);
		String productimage = "data:" + filetype + ";base64," + filebase64 + "";
		if (productimage.equals("data:application/octet-stream;base64,")) {
			pro.setProductImage(oldBean.getProductImage());
		} else {
			pro.setProductImage(productimage);
		}
		proService.insertProduct(pro);

		return "redirect:/backend/product/all";
	}

}
