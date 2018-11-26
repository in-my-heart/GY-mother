<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>部门管理</title>
    <jsp:include page="/common/header.jsp"></jsp:include>
  </head>
  <body class="gray-bg">
	<div class="wrapper wrapper-content ">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox-content">
					<div id="jsTree"></div>
				</div>
				<div class="form-group ">
					<div class="col-sm-12 col-sm-offset-12">
						<button type="submit" onclick="loadUser()" class="btn btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
	  <jsp:include page="/common/footer.jsp"></jsp:include>
	</div>
<script type="text/javascript">
var prefix = "<%=basePath%>";
	$(document).ready(function() {
		getTreeData()
	});
	function getTreeData() {
		$.ajax({
			type : "GET",
			url : prefix+"/user/tree",
			success : function(tree) {
				loadTree(tree);
			}
		});
	}
	function loadTree(tree) {
		$('#jsTree').jstree({
			'core' : {
				'data' : tree
			},
			"plugins" : [ "checkbox" ]
		});
		$('#jsTree').jstree().open_all();
	}
	function loadUser() {
		var userNames, userIds;
		var ref = $('#jsTree').jstree(true); // 获得整个树
		userIds = ref.get_bottom_selected();
		users = ref.get_bottom_checked('true');
		var txt = "";
		for ( var user in users) {
			if (users[user].state.mType == "user") {
				txt = txt + users[user].text + ",";
			}
		}
		parent.loadUser(userIds, txt);
		var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
		parent.layer.close(index);
	}
</script>
</body>
</html>
