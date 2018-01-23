<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="jl" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
	
	<link rel="stylesheet" type="text/css" href="./Resources/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./Resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="./Resources/css/responsive.css">
	
	<script type="text/javascript" src="./Resources/js/jquery.js"></script>
	<script type="text/javascript" src="./Resources/js/main.js"></script>
		
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./common.js"></script>
	
	<!-- Bootstrap Core CSS -->
	<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- MetisMenu CSS -->
	<link href="./Resouces_admin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	
	<!-- DataTables CSS -->
	<link href="./Resouces_admin/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
	
	<!-- DataTables Responsive CSS -->
	<link href="./Resouces_admin/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	
	<!-- Custom CSS -->
	<link href="./Resouces_admin/dist/css/sb-admin-2.css" rel="stylesheet">
	
	<!-- Custom Fonts -->
	<link href="./Resouces_admin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	<style type="text/css">

.paginationdiv {
	text-align: right;
}

.comm_qna_read {
	margin-left: 10px;
	margin-right: 10px;
}

.replecontent_qna {
	width:98%;
	margin-left: 20px;
	float: left;
}

.replecontent_qna .repsumbtn {
	width: 100px;
	float: left;
}

.replecontent_qna .replesumtext {
	float: left;
	width: 800px;
}



.replecontent_qna .btnclass_mod {
	width: 300px;
	float: right;
}

.replecontent_qna .btnclass1, .replecontent_qna .btnclass2, .replecontent_qna .btnclass3
	{
	width: 100px;
	float: left;
}

</style>
	
	<script>

	$(document).ready(function() {
		
		/* 시작했을 때 find_reple() 이벤트 실행 */
		find_reple();
		
		/* 기본 모달 창 닫기 버튼 눌렀을 때 이벤트 발생 */
		$("#basic_modal_Yes").on("click",function(){
			$("#basic_modal").modal("hide");
		});
		
		/* 댓글 작성 버튼 클릭 시 이벤트 발생 */
		$("#reple_submit_btn").on("click", function() {
			$("#add_reple_modal").modal("show");
		});
		$("#add_reple_modal_Yes").on("click",function(){
			reple_add();
		});
		$("#add_reple_modal_No").on("click",function(){
			$("#add_reple_modal").modal("hide");
		});
		var reple_add = function(){
			var formData = $("#reple_submit").serialize();
			$.ajax({
				type : "POST",
				url : "community_qna_reple_add.do",
				data : formData,
				success	: function(rt) {
					$("#add_reple_modal").modal("hide");
					if(rt=="ok"){
						$("#basic_mobody").text("댓글이 등록 되었습니다.");
						$("#basic_modal").modal("show");
						$("#basic_modal").on("hidden.bs.modal",function(){
							$("#basic_modal").modal("hide");
							$("#com_qna_reple_content").val("");
							find_reple();
						});
					}else if(rt=="no"){
						$("#basic_mobody").text("댓글 처리가 실패 되었습니다.");
						$("#basic_modal").modal("show");
						$("#basic_modal").on("hidden.bs.modal",function(){
							$("#basic_modal").modal("hide");
							find_reple();
						});
					}
			    }
			});
			
			/* $("#add_reple_modal").modal("hide");
			$("#basic_mobody").html("<h4>댓글이 등록 되었습니다.</h4>");
			$("#basic_modal").modal("show");
			$("#basic_modal").on("hidden.bs.modal",function(){
				$("#reple_submit").submit();
			}); */
		}
		
		$("#btnClose").on("click", function() {
			$("#repleModal").modal("hide");
			$("#rsModal").modal("hide");
			$("#rdModal").modal("hide");
			$("#repleModal").modal("hide");
		});
		
		/* $("#btnModRep").on("click", function() {
			$("#reple_mod").submit();
		}); */
		
		$("#btnSub").on("click", function() {
			$("#replewritecompleteModal").modal("show");
		});
		
		/* $("#replewritecompleteModal").on("hidden.bs.modal",function(){
			$("#reple_submit").submit();
		}); */
		
		/* 댓글 삭제 이벤트 */
		$(document).on("click",".delRe",function(){
			var com_qna_reple_no = $(this).attr("aa");
			var com_qna_no = $(this).attr("bb");
			$("#del_modal").modal("show");
			$("#del_modal_Yes").on("click",function(){
				var url = "community_qna_reple_del.do?com_qna_no="+com_qna_no + "&com_qna_reple_no=" + com_qna_reple_no;
				ajaxGet(url,function(rt){
					$("#del_modal").modal("hide");
					if(rt=="ok"){
						$("#basic_mobody").html("<h4>댓글이 삭제 되었습니다.</h4>");
						$("#basic_modal").modal("show");
						$("#basic_modal").on("hidden.bs.modal",function(){
							$("#basic_modal").modal("hide");
							find_reple();
						});
					}else if(rt=="no"){
						$("#basic_mobody").html("<h4>댓글 삭제 처리가 실패 되었습니다.</h4>");
						$("#basic_modal").modal("show");
						$("#basic_modal").on("hidden.bs.modal",function(){
							$("#basic_modal").modal("hide");
							find_reple();
						});
					}
				});
			});
			$("#del_modal_No").on("click",function(){
				$("#del_modal").modal("hide");
			}); 
			/* $("#del_com_qna_no").val( $(this).attr("del_com_qna_no") );
			$("#del_com_qna_reple_no").val( $(this).attr("del_com_qna_reple_no") );
			$('#del_modal').modal('show');
			$("#del_modal_Yes").on("click",function(){
				var del_com_qna_no = $("#del_com_qna_no").val();
				var del_com_qna_reple_no = $("#del_com_qna_reple_no").val();
				$("#del_modal").modal("hide");
				$("#basic_mobody").html("<h4>댓글이 삭제 되었습니다.</h4>");
				$("#basic_modal").modal("show");
				$("#basic_modal").on("hidden.bs.modal",function(){
					location.href = "community_qna_reple_del.do?com_qna_no=" + 
					del_com_qna_no + "&com_qna_reple_no=" + del_com_qna_reple_no;
					find_reple();
				});
			});
			$("#del_modal_No").on("click",function(){
				$("#del_modal").modal("hide");
			}); */
		});
		/* 댓글 삭제 이벤트 */
		
		$(".btnDel").on("click", function() {
			$("#repledeletecompleteModal").modal("show");
		});
		
		$("#btnDelQna").on("click", function() {
			$("#qnadeletecompleteModal").modal("show");
			
		});
		
		/* 글 삭제 이벤트 */
		$("#text_del_Yes").on("click",function(){
			$("#text_del_modal").modal("hide");
			$("#basic_mobody").html("<h4>글이 삭제되었습니다.</h4>");
			$("#basic_modal").modal("show");
			$("#basic_modal").on("hidden.bs.modal",function(){
				/* location.href="community_qna_list.do" */
				$("#Qna_delete").submit();
			});
		});
		$("#text_del_No").on("click",function(){
			$("#text_del_modal").modal("hide");
		});
		/* 글 삭제 이벤트 */
		
		
		/* 댓글 수정 이벤트 */
		$(document).on("click",".modReple",function() {
			$("#com_qna_reple_no").val($(this).attr("xyz"));
			$("#content").val($("#" + $(this).attr("abcd")).text());	
			$("#repleModal").modal("show");
			$("#btnMod").on("click",function(){
				var formData = $("#reple_form").serialize();
				$.ajax({
					type : "POST",
					url : "community_qna_reple_mod.do",
					data : formData,
					success	: function(rt) {
						$("#repleModal").modal("hide");
						if(rt=="ok"){
							$("#repleModal").modal("hide");
							$("#basic_mobody").html("<h4>댓글이 수정 되었습니다.</h4>");
							$("#basic_modal").modal("show");
							$("#basic_modal").on("hidden.bs.modal",function(){
								find_reple();
							});
						}else if(rt=="no"){
							$("#repleModal").modal("hide");
							$("#basic_mobody").html("<h4>댓글 수정 처리가 실패 되었습니다.</h4>");
							$("#basic_modal").modal("show");
							$("#basic_modal").on("hidden.bs.modal",function(){
								find_reple();
							});
						}
				    }
				});	
				
				
			});
			$("#btn_mod_Close").on("click",function(){
				$("#repleModal").modal("hide");
			});
		});
		/* 댓글 수정 이벤트 */
		
		$(document).on("click",".recom", function() {
			var user_id=$(this).attr("user_id");
			var com_qna_reple_no=$(this).attr("com_qna_reple_no");
			var dc = "?dc=" + new Date().getTime();
			var url ="community_qna_reple_recom.do" + dc +"&com_qna_reple_no="+com_qna_reple_no+"&user_id="+user_id;
			ajaxGet(url, function(rt) {
				$("#recom_count"+com_qna_reple_no).html("<h5>"+rt+"</h5>");
				find_reple();
			});
		});
	});
	
	/* 댓글 조회 비동기 처리 */
	function find_reple(){
		var url = "community_qna_read_reple.do?com_qna_no="+${vo.com_qna_no};
	 	ajaxGet(url,function(rt){
	 		if(rt!=''){
			 	var list = window.eval("("+rt+")");
			 	var html = "";
			 		html +="<table class='"+"table-hover'"+">";
			 	for( var i = 0 ; i < list.data.length ; i++ ){
			 		html += "<tr><td width="+"150"+"><h4>"+list.data[i].user_id+"</h4></td>";
			 		html += "<td width="+"1000"+"><span id='rb_"+list.data[i].com_qna_reple_no+"'><h4>"+list.data[i].com_qna_reple_content+"</h4></span>";
			 		html += "<td width="+"220"+"><h5>"+list.data[i].the_time+"</h5></td>";
			 		html += "<td width="+"30"+"><span id='recom_count+"+list.data[i].com_qna_reple_no+"'><h5>"+list.data[i].recom_count+"</h5></span></td>";
			 		html += " <td width="+"50"+"><input type='button' class='recom btn btn-warning btn-xs' value='추천' user_id='${user_id}' com_qna_reple_no='"+list.data[i].com_qna_reple_no+"' /></td>";
			 		if('${user_id}' == list.data[i].user_id){
			 			html += " <td width="+"50"+"><input type='button' class='modReple btn btn-info btn-xs' value='수정' abcd='rb_"+list.data[i].com_qna_reple_no+"' xyz='"+list.data[i].com_qna_reple_no+"' /></td>";
				 		html += " <td width="+"50"+"><input type='button' class='delRe btn btn-danger btn-xs' value='삭제' aa='"+list.data[i].com_qna_reple_no+"' bb='"+list.data[i].com_qna_no+"'/></td>";	
					}
					html +="</tr>";
			 	}//end for
					html +="</table>";
                $('#reple_tr').html(html);
		 	}else{
		 		$('#reple_tr').html("");
		 	}
	 	});
		}
	/* 댓글 조회 비동기 처리 */

</script>
	
</head>
<body>
	
	<!-- *********************  header  ************************ -->
         <%@include file="./jsp/header_page.jsp"%>  
	<!-- *********************  header - end  ************************ --> 
	<div class="head" id="header">
	
		<ul id="Navtab" class="nav nav-tabs commu_nav-tabs" role="tablist">
			<li ><a href="community_board_list.do" ><h3>FREE BOARD</h3></a></li>

			<li ><a href="community_qna_list.do"  ><h3>QnA BOARD</h3></a></li>

			<li ><a href="community_review_list.do" ><h3>REVIEW BOARD</h3></a></li>
		</ul>
	</div>
	
	<div class="row comm_qna_read">
		<div class="col-lg-12">
		<hr style="border: solid 0.5px black;">
			<!-- 테이블 -->

			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th><h4>번호</h4></th>
							<th><h4>제목</h4></th>
							<th><h4>글쓴이</h4></th>
							<th><h4>조회</h4></th>
							
						</tr>
					</thead>
					
						<tr>
							<td><h4>${vo.com_qna_no}</h4></td>
							<td><h4>${vo.com_qna_title}</h4></td>
							<td><h4>${vo.user_id}</h4></td>
							<td><h4>${vo.view_count}</h4></td>
							
						</tr>
						<tr>
							<td class="table_content" colspan="5">
								<div class="pre"
									style="padding: 10px; height: auto; min-height: 200px; overflow: auto;">
									<pre style="white-space: pre-wrap;"><h4>${vo.com_qna_content}</h4></pre>
								</div>
							</td>
						</tr>
					</table>
					<%-- <table class="table-hover table_qna_read" >
					<hr style="border: solid 0.5px black;">
						<jl:forEach var="rpl" items="${rp}" varStatus="vs">
							<tr>
								<td width="150">
									<h4>${rpl.user_id}</h4>
								</td>
								<td width="1000">
									<span id="rb_${rpl.com_qna_reple_no}"><h4>${rpl.com_qna_reple_content}</h4></span>
								</td>
								<td width="250"><h5>${rpl.the_time}</h5></td>
								<td width="30">
									<span id="recom_count${rpl.com_qna_reple_no}"><h5>${rpl.recom_count}</h5></span>
								</td>
								<td width="50">
								<!-- <a user_id="${user_id}" com_qna_reple_no="${rpl.com_qna_reple_no}" id="recom" class="btn btn-primary btn-sm" href="community_qna_reple_recom.do?user_id=${user_id }&com_qna_reple_no=${rpl.com_qna_reple_no}&com_qna_no=${rpl.com_qna_no}">추천</a> -->	
								<jl:if test="${user_id ne ''}">
									<a user_id="${user_id}" com_qna_reple_no="${rpl.com_qna_reple_no}" class="btn btn-warning btn-xs recom"">추천</a>
								</jl:if>
								</td>
								<td width="50"> 
								<jl:if test="${rpl.user_id eq user_id}"> 
									<a abcd="rb_${rpl.com_qna_reple_no}" xyz="${rpl.com_qna_reple_no}" class="modReple btn btn-info btn-xs" href="#">수정</a>
								</jl:if>
								</td>
								<td width="50">
								<jl:if test="${rpl.user_id eq user_id}"> 
								<input type="button" class="btn btn-danger btn-xs showDelModal" 
									del_com_qna_no="${rpl.com_qna_no}"
									del_com_qna_reple_no="${rpl.com_qna_reple_no}" value="삭제"/>		
								</jl:if>	
								</td>
							</tr>
						</jl:forEach>
				</table> --%>
				<table>
					<hr style="border: solid 0.5px black;">
				</table>
				<div id="reple_tr" style=" height: auto; min-height: 5px; overflow: auto;">
			
				</div>
				<br><br>
			</div>
			<!-- /.table-responsive -->
			
		</div>
		<!-- /.col-lg-12 -->
		<div class="replecontent_qna">
		<form id="reple_submit">
			<jl:if test="${user_id ne ''}">
				<div class="replesumtext">
					<input class="form-control" type="text" name="com_qna_reple_content" id="com_qna_reple_content"placeholder="댓글을 입력하세요."/>
					<input type="hidden" name="user_id" value="${user_id}"/>
					<input type="hidden" name="com_qna_no" value="${vo.com_qna_no}"/>
				</div>
				<div class="repsumbtn">
					<input id="reple_submit_btn" type="button" value="댓글작성" class="btn btn-primary">
				</div>
			</jl:if>
		</form>
		<div class="btnclass_mod">
			<div class="btnclass1">
				<form action="community_qna_list.do" method="post">
					<input type="submit" value="QnA목록" class="btn btn-basic" />
				</form>
			</div>
			<div class="btnclass2">
				<form action="community_qna_del.do" method="POST" id="Qna_delete">
					<input type="hidden" name="com_qna_no" value="${vo.com_qna_no}" />
					<jl:if test="${vo.user_id eq user_id}">
						<input type="button" class="btn btn-danger" value="QnA삭제"
							data-toggle="modal" data-target="#text_del_modal" />
					</jl:if>
				</form>
			</div>
			<div class="btnclass3">
				<form action="community_qna_mod.do" method="post">
					<input type="hidden" name="com_qna_no" value="${vo.com_qna_no}" />
					<input type="hidden" name="com_qna_title" value="${vo.com_qna_title}" /> 
					<input type="hidden" name="com_qna_content" value= ' ${vo.com_qna_content}' />
					<jl:if test="${vo.user_id eq user_id}">
						<input type="submit" class="btn btn-info" value="글수정" />
					</jl:if>
				</form>
			</div>
		</div>
	</div>
	</div>
	</br>
	
	
	<div class="modal fade" id="repledeletecompleteModal" role="dialog">
		    <div class="modal-dialog">
		      <!-- Modal content-->
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>댓글 삭제 완료!</p>
		        </div>
		         <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" value="닫기">
		        </div>
		      </div>
	    </div>
	</div>
	
		<div class="modal fade" id="qnadeletecompleteModal" role="dialog">
		    <div class="modal-dialog">
		      <!-- Modal content-->
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>QnA 삭제 완료!</p>
		        </div>
		         <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" value="닫기">
		        </div>
		      </div>
	    </div>
	</div>
	
	<div class="modal fade" id="replemodcompleteModal" role="dialog">
		    <div class="modal-dialog">
		      <!-- Modal content-->
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>댓글 수정 완료!</p>
		        </div>
		         <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" value="닫기">
		        </div>
		      </div>
	    </div>
	</div>
	
	<div class="modal fade" id="replewritecompleteModal" role="dialog">
		    <div class="modal-dialog">
		      <!-- Modal content-->
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>댓글 작성 완료!</p>
		        </div>
		         <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" value="닫기">
		        </div>
		      </div>
	    </div>
	</div>
	
	
	
	<!-- 모달 부분 -->

	<!-- 댓글 수정 modal창 시작 -->
	<form id="reple_form">
		<div id="repleModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div id="reple_head" class="modal-header" align="center"><h4>댓글수정</h4></div>
					<div id="reple_body" class="modal-body" align="center">
						<textarea id="content" name='com_qna_reple_content'class='form-control' rows='7'></textarea>
					</div>
					<div id="ft" class="modal-footer">
						<button type='button' class='btn btn-default' id='btnMod'>수정</button>
						<button type='button' class='btn btn-primary' id='btn_mod_Close'>취소</button>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="com_qna_no" value="${vo.com_qna_no}" name="com_qna_no" /> 
		<input id="com_qna_reple_no" type="hidden" name="com_qna_reple_no" />
	</form>
	<!-- 댓글 수정 modal창 시작 -->
	
	<!-- 댓글 삭제 modal창 시작 -->
	<div id="del_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="mohead" class="modal-header" align="center"><h4>댓글 삭제</h4></div>
				<div id="mobody" class="modal-body" align="center">
					<h4>댓글을 삭제하시겠습니까?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='del_modal_Yes'>삭제</button>
					<button type='button' class='btn btn-primary' id='del_modal_No'>취소</button>
				</div>
			</div>
		</div>
	</div>
   	<input type="hidden" id="del_com_qna_no" value="0"/>
	<input type="hidden" id="del_com_qna_reple_no" value="0"/>
	<!-- 댓글 삭제 modal창 끝 -->
	<!-- 글 삭제 modal창 시작 -->
	<div id="text_del_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="text_del_head" class="modal-header" align="center"><h4>글 삭제</h4></div>
				<div id="text_del_body" class="modal-body" align="center">
				<h4>글을 삭제 하시겠습니까?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='text_del_Yes'>삭제</button>
					<button type='button' class='btn btn-primary' id='text_del_No'>취소</button>
				</div>
			</div>
		</div>
	</div>		
	<!-- 글 삭제 modal창 시작 -->	
	<!-- 댓글 등록 modal창 시작 -->
	<div id="add_reple_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="add_reple_mohead" class="modal-header" align="center"><h4>댓글 등록</h4></div>
				<div id="add_reple_mobody" class="modal-body" align="center">
					<h4>댓글을 등록 하시겠습니까?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='add_reple_modal_Yes'>등록</button>
					<button type='button' class='btn btn-primary' id='add_reple_modal_No'>취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 댓글 등록 modal창 끝 -->
	
	<!-- 기본 modal창 시작 -->
	<div id="basic_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="basic_mobody" class="modal-body" align="center">
				</div>
				<div id="basic_ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='basic_modal_Yes'>닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 기본 modal창 끝 -->
	
	
	<!-- ******************************* footer ******************************* -->
		  <%@include file="./jsp/footer.jsp"%>  
	<!--  end footer  -->
</body>
</html>