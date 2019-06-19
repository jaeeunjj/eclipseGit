/**
 *  $("#sample").sessionTimer(120, "moveURL");
 */
$.fn.sessionTimer=function(timeout, ajaxUrl){
		if(!timeout){
			console.error("세션 타임아웃 값이 전달되지 않았음");
			return this;
		}
		function lpad(text, size, padding){
			text = text+"";
			if(text.length<size){
				var paddingCnt = size - text.length;
				for(var num=0; num<paddingCnt; num++){
					text = padding+""+text;
				}
			}
			return text;
		}
		function makeTimeString(time){
			var min = Math.trunc(time/60);
			var sec = time%60;
			return lpad(min, 2, '0')+":"+lpad(sec, 2, '0');
		}
		function showMessage(){
			var btnArray = [
				$('<input type="button" value="연장" class="btn" id="yesBtn"/>'),
				$('<input type="button" value="취소" class="btn" id="noBtn"/>')
			];
			$(btnArray).each(function(index, arrayElement){
				arrayElement.on("click", function(){
					var btnId = $(this).prop("id");
					if(btnId=="yesBtn"){
						$.ajax({
							url : !ajaxUrl?"":ajaxUrl,
							method : "head",
							success : function() {
								timer = timeout;
							},
							error : function(errorResp) {
								console.log(errorResp.status);
							}
						});
					}
					$(this).parents("#msgArea").remove();
				});
			});
			var msgTag = 
				$("<div id='msgArea' />").append(
					$("<div>").text("만료 시간이 1분 남았는데, 연장 할래?"),
					$("<div>").append(
						btnArray[0],
						"&nbsp;",
						btnArray[1]
					)
				);
			$("body").append(msgTag);
			return msgTag;
		}
		var timer = timeout;
		var element = this;
		var msgArea = null;
		var timerJob = setInterval(function() {
			
			if(timer==0){
				clearInterval(timerJob);
				if(msgArea) msgArea.remove();
				location.reload();
				return;
			}else if(timer==2){
				msgArea = showMessage();
			}
			element.text(makeTimeString(timer--));
			
		}, 1000);
		return this;
	}
	