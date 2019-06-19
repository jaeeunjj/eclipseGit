package kr.or.ddit.vo;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.UpdateHint;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of="bo_no")
@NoArgsConstructor
public class BoardVO implements Serializable {
	private Integer startPdsNo;
	private Long rnum;
	
	@NotNull(groups=UpdateHint.class)
	private Integer bo_no;
	
	@NotBlank
	private String bo_title;
	@NotBlank
	private String bo_writer;
	
	@NotBlank
	private String bo_pass;
	private String bo_date;
	private String bo_content;
	@NotBlank
	private String code_id;
	private Integer bo_hit;
	private Integer bo_report;
	private Integer bo_like;
	private Integer bo_hate;
	@NotBlank
	private String bo_ip;
	private String bo_mail;
	private Integer bo_parent;
	private boolean likeFlag;
	MultipartFile[] bo_files;
	
	private List<ReplyVO> replyList;
	private List<PdsVO> pdsList;
	private List<PdsVO> savepdsList;
	
	private Integer[] pdsDels;

	@Value("#{appInfo['pdsPath']}")//spEL사용
	String pdsPath;
	
	public void setBo_files(MultipartFile[] bo_files) {
		this.bo_files = bo_files;
		pdsList = new ArrayList<PdsVO>(bo_files.length);
			for(MultipartFile multi: bo_files){
				if(bo_files!=null &&StringUtils.isNotBlank(multi.getOriginalFilename())){
					String saveName=UUID.randomUUID().toString();
					File saveFile = new File(pdsPath, saveName);
					
					PdsVO pdsVO= new PdsVO(multi);
					pdsVO.setPds_savepath(saveFile.getAbsolutePath());
					pdsList.add(pdsVO);
			}
		}
	}
	
}
