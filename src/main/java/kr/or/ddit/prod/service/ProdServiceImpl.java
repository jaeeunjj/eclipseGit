package kr.or.ddit.prod.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.prod.dao.IProdDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

@Service
public class ProdServiceImpl implements IProdService {
	
	@Inject
	IProdDAO prodDAO; 
	
	@Value("#{appInfo['prodImages']}")//spEL사용
	String imageFolderUrl;
	
	File saveFolder;

	@Inject
	WebApplicationContext rootcontainer;
	
	@PostConstruct
	public void init(){
		String realPath = rootcontainer.getServletContext().getRealPath(imageFolderUrl);
		saveFolder = new File(realPath);
		if(saveFolder.exists()) saveFolder.mkdirs();
		
	}
	
	
	private void imagePreProcess(ProdVO prod){
		MultipartFile image = prod.getProd_image();
		String savename = UUID.randomUUID().toString();
		if(image!=null && (image.getOriginalFilename()!=null)
				&& image.getOriginalFilename().trim().length()>0){
		prod.setProd_img(savename);
		}
		
	}
	
	
	private void imageProcess(ProdVO prod){
		MultipartFile image = prod.getProd_image();
		if(image!=null && (image.getOriginalFilename()!=null)
				&& image.getOriginalFilename().trim().length()>0){
			String savename = prod.getProd_img();
			 File saveFile = new File(saveFolder,savename);
			
			try(
					InputStream is = image.getInputStream();
					
					){
				
					FileUtils.copyInputStreamToFile(is,saveFile);
				
			}catch (IOException e) {
				throw new RuntimeException(e);
			}
			
		}
		
	}
	

	@Override
	public ServiceResult createProd(ProdVO prod) {
		ServiceResult result = null;
		imagePreProcess(prod);
		int rowCnt = prodDAO.insertProd(prod);
		if(rowCnt > 0) {
			imageProcess(prod);
		result = ServiceResult.OK;
		}else {
		
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	@Override
	public long retrieveProdCount(PagingVO pagingVO) {
		return prodDAO.selectProdCount(pagingVO);
	}

	@Override
	public List<ProdVO> retrieveProdList(PagingVO pagingVO) {
		return prodDAO.selectProdList(pagingVO);
	}

	@Override
	public ProdVO retrieveProd(String prod_id) {
		ProdVO prod = prodDAO.selectProd(prod_id);
		if(prod==null) throw new CommonException(prod_id+"상품이 존재하지 않습니다.");
		return prod;
	}

	@Override
	public ServiceResult modifyProd(ProdVO prod) {
		retrieveProd(prod.getProd_id());
		imagePreProcess(prod);
		
		int rowCnt = prodDAO.updateProd(prod);
		ServiceResult result = ServiceResult.FAILED;
		if(rowCnt > 0) {
			imageProcess(prod);
			result = ServiceResult.OK;
		}
		
		return result;
	}
}





