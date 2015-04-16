package caerusapp.web.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import caerusapp.service.common.ILoginManagement;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;

@Controller
public class AdminManageMastersController {

	@Autowired
	ILoginManagement loginManagement;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_MASTERS)
	String loadMastersPage(@ModelAttribute("masterType") String masterType,@ModelAttribute(value="alreadyExists")String alreadyExists,Model model){
		
		List<String> masters = CaerusCommonUtility.getAdminMasters();
		List<String> results = new ArrayList<String>();
		
		if(null != masterType && masterType.trim().length() > 0){
			results = loginManagement.getMasterResults(masterType);
		}
		else {
			masterType = masters.get(0);
			results = loginManagement.getMasterResults(masters.get(0));
		}
		model.addAttribute("results",results);
		model.addAttribute("masters",masters);
		model.addAttribute("masterType",masterType);
		model.addAttribute("alreadyExists",alreadyExists);
		
		return "admin/admin_manage_masters";
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_GET_SELECTED_MASTER,method = RequestMethod.POST)
	String getSelectedMaster(@RequestParam("masterType") String masterType,RedirectAttributes redirectAttributes){
		redirectAttributes.addFlashAttribute("masterType",masterType);
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MASTERS;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_ADD_MASTER)
	String addMaster(@RequestParam("masterValue") String masterValue,@RequestParam("masterType") String masterType,RedirectAttributes redirectAttributes,Model model){
		
		if(masterType != null && masterType.trim().length() > 0 && masterValue != null && masterValue.trim().length() > 0){
			if(! loginManagement.checkMasterValueExists(masterType,masterValue)){
				loginManagement.addMasterValue(masterType,masterValue);
			}
			else {
				redirectAttributes.addFlashAttribute("alreadyExists",masterValue +" Already Exists in "+masterType);
				
				model.addAttribute("alreadyExists",masterValue +" Already Exists in "+masterType);
				model.addAttribute("masters",CaerusCommonUtility.getAdminMasters());
			}
		}
		redirectAttributes.addFlashAttribute("masterType",masterType);
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MASTERS;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_DELETE_MASTER)
	String deleteMaster(@RequestParam("masterValue") String masterValue,@RequestParam("masterType") String masterType,RedirectAttributes redirectAttributes){
		loginManagement.deleteMasterValue(masterType,masterValue);
		
		redirectAttributes.addFlashAttribute("masterType",masterType);
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MASTERS;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_EDIT_MASTER)
	String editMaster(@RequestParam("masterValue") String newMasterValue,@RequestParam("masterType") String masterType,@RequestParam("oldValue") String oldValue ,RedirectAttributes redirectAttributes){
		
		loginManagement.updateMasterValue(masterType,oldValue,newMasterValue);
		redirectAttributes.addFlashAttribute("masterType",masterType);
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MASTERS;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_UPLOAD_MASTERS_FILE,method = RequestMethod.POST)
	String uploadMastersFile(@RequestParam("excelOrCsv") MultipartFile excelOrCsvFile,@RequestParam("masterType") String masterType,RedirectAttributes redirectAttributes) throws IOException{
		Set<String> elements = new TreeSet<String>();
		Set<String> existingValues = new TreeSet<String>();
		
		existingValues = new HashSet<String>(loginManagement.getMasterResults(masterType));
		
		if(null != excelOrCsvFile && excelOrCsvFile.getSize() > 0){
			if(excelOrCsvFile.getContentType() != null && excelOrCsvFile.getContentType().equals("application/octet-stream") && CaerusCommonUtility.getFileExtension(excelOrCsvFile.getOriginalFilename()).equalsIgnoreCase("csv"))
			{
				elements = CaerusCommonUtil.readCSVOrTextFile(excelOrCsvFile.getBytes());
				System.out.println("CSV File");
			}
			
			if(excelOrCsvFile.getContentType() != null && excelOrCsvFile.getContentType().equals("application/octet-stream") &&(CaerusCommonUtility.getFileExtension(excelOrCsvFile.getOriginalFilename()).equalsIgnoreCase("xls") || CaerusCommonUtility.getFileExtension(excelOrCsvFile.getOriginalFilename()).equalsIgnoreCase("xlsx")))
			{
				try {
					elements = CaerusCommonUtil.readExcelFiles(excelOrCsvFile.getInputStream());
				}
				catch(OfficeXmlFileException versionException){
					System.err.println("Version Issue with XLS.Please upload XLS File.");
				}
				System.out.println("XLS File");
			}
			
			if(null != existingValues && null != elements){
				elements.addAll(existingValues);
			}
			
			loginManagement.addMasterValues(elements,masterType);
			
			
			String mimeType = excelOrCsvFile.getContentType();
			System.err.println(mimeType);
		}
		else {
			redirectAttributes.addFlashAttribute("alreadyExists","Please Upload a File");
		}
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MASTERS;
	}
	
	
}
