
function makeReplyList(resp){
	var replyList = resp.dataList;
	var trTags = [];
	$(replyList).each(function(idx, reply){
		var tr = $("<tr>").prop("id", reply.rep_no )
						 .append(	 
							$("<td>").text(reply.rep_writer),		 
							$("<td>").text(reply.rep_ip),		 
							$("<td>").text(reply.rep_comment),		 
							$("<td>").text(reply.rep_date),	
//								$("<td>").append($("<input type='hidden' class='repno' value='${reply.rep_no}'>")),
//								$("<td>").append($("<input type='text' class='deletePass'>"
//										)),
//								$("<td>").append($("<input type='button' value='삭제' class='deletRep'>")),
//								$("<td>").append(
//										$("<input>").attr({
//											type:'hidden'
//											,class:'repno'
//											,value:reply.rep_no
//										}))
								$("<td>").append(
								$("<input>").attr({
									type:'text'
									,class:'deletePass'
									}),
								$("<input>").attr({
									type:'button'
									,value:'삭제'
									,class:'deleteRep'
									,id:reply.rep_no
								})
							
							)


						 );
		trTags.push(tr);
	
	
	});
	
	return trTags;
}