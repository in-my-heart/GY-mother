<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <title>人脸识别</title>
    <jsp:include page="/common/header.jsp"></jsp:include>
    <link href="<%=basePath%>/bootstrap/css/layui.css" rel="stylesheet">
    <style type="text/css">
        #exampleTable {
            table-layout: fixed;
            word-break: break-all;
            word-wrap: break-all;
        }

        .cmcbsearch {
            height: 30px;
            font-size: inherit;
            width: 168px;
        }

        .faceimage {
            border-radius: 50%;
        }
    </style>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content ">
    <div class="col-sm-12">
        <div class="ibox">
            <div class="ibox-body">
                <div class="columns pull-left">
                    微信昵称:<input id="nikeName" class="cmcbsearch" placeholder="请输入微信昵称" text">
                    <button class="btn btn-success" onclick="reLoad()"> 查 询</button>
                </div>
                <button id="btn_delete" type="button" class="btn btn-default btn-sm">
                    <span class="btn layui-btn-danger" aria-hidden="true"></span>删除
                </button>
                <table id="exampleTable" data-mobile-responsive="true">

                </table>
                <!-- 新增或修改弹框 -->
                <div class="modal fade" id="addAndUpdate" tabindex="-1" role="dialog"
                     aria-labelledby="addAndUpdateLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="addAndUpdateLabel">修改信息</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="imagePath">图片路径</label>
                                    <input type="text" name="imagePath" class="form-control" id="imagePath"
                                           placeholder="图片路径">
                                </div>
                                <div class="form-group">
                                    <label for="faceToken">百度标识</label>
                                    <input type="text" name="faceToken" class="form-control" id="faceToken"
                                           placeholder="百度标识">
                                </div>

                                <div class="form-group">
                                    <label for="faceProbability">置信度</label>
                                    <input type="text" name="faceProbability" class="form-control" id="faceProbability"
                                           placeholder="置信度">
                                </div>

                                <div class="form-group">
                                    <label for="age">年龄</label>
                                    <input type="text" name="age" class="form-control" id="age" placeholder="年龄">
                                </div>
                                <div class="form-group">
                                    <label for="beauty">颜值</label>
                                    <input type="text" name="beauty" class="form-control" id="beauty" placeholder="颜值">
                                </div>
                                <div class="form-group">
                                    <label for="expressionType">表情</label>
                                    <input type="text" name="expressionType" class="form-control" id="expressionType"
                                           placeholder="表情">
                                </div>
                                <div class="form-group">
                                    <label for="faceShapeType">脸型</label>
                                    <input type="text" name="faceShapeType" class="form-control" id="faceShapeType"
                                           placeholder="脸型">
                                </div>
                                <div class="form-group">
                                    <label for="gender">性别</label>
                                    <input type="text" name="gender" class="form-control" id="gender" placeholder="性别">
                                </div>
                                <div class="form-group">
                                    <label for="glassesType">眼镜类型</label>
                                    <input type="text" name="glassesType" class="form-control" id="glassesType"
                                           placeholder="眼镜类型">
                                </div>
                                <div class="form-group">
                                    <label for="raceType">肤色</label>
                                    <input type="text" name="raceType" class="form-control" id="raceType"
                                           placeholder="肤色">
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span
                                        class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭
                                </button>
                                <button type="button" id="btn_add_update_submit" class="btn btn-primary btn-sm"
                                        data-dismiss="modal"><span
                                        class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <script type="text/javascript">
            var s_edit_h = 'hidden';
            var s_remove_h = 'hidden';
        </script>
    </div>
    <div>
        <script type="text/javascript">
            s_edit_h = '';
        </script>
    </div>
    <div>
        <script type="text/javascript">
            var s_remove_h = '';
        </script>
    </div>

</div>
<div>
    <jsp:include page="/common/footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
    var prefix = "<%=basePath%>";
    $(function () {
        load()
    });
    function load() {
        $('#exampleTable').bootstrapTable({
            method: 'get', // 服务器数据的请求方式 get or post
            url: prefix + "bdface/list", // 服务器数据的加载地址
            iconSize: 'outline',
            toolbar: '#exampleToolbar',
            striped: true, // 设置为true会有隔行变色效果
            dataType: "json", // 服务器返回的数据类型
            pagination: true, // 设置为true会在底部显示分页条
            // queryParamsType : "limit",
            // //设置为limit则会发送符合RESTFull格式的参数
            singleSelect: false, // 设置为true将禁止多选
            pageSize: 10, // 如果设置了分页，每页数据条数
            pageNumber: 1, // 如果设置了分布，首页页码
            // search : true, // 是否显示搜索框
            showColumns: false, // 是否显示内容下拉框（选择显示的列）
            sidePagination: "server", // 设置在哪里进行分页，可选值为"client" 或者
            // "server"
            queryParams: function (params) {
                return {
                    // 说明：传入后台的参数包括offset开始索引，limit步长，sort排序列，order：desc或者,以及所有列的键值对
                    limit: params.limit,
                    offset: params.offset,
                    nikeName: $('#nikeName').val()
                };
            },
            columns: [
                {
                    field: 'Number',
                    width: 25,
                    formatter: function (value, row, index) {
                        return index + 1;
                    }
                },
                {
                    checkbox: true
                },
                {
                    field: 'faceId', // 列字段名
                    title: '序号', // 列标题,
                    visible: false,
                    width: 50
                },
                {
                    field: 'logId',
                    title: '日志ID',
                    visible: false,
                    width: 100
                }, {
                    field: 'imagePath',
                    title: '人脸图片',
                    width: 70,
                    formatter: function (value, row, index) {
                        var values = '.' + value;
                        var a = '<img title="年龄:' + row.age + ',颜值:' + row.beauty + '" class="faceimage" src="' + values + '" width="66px" height="66px" onerror="this.src=\'./image/loadfail.png\'">';
                        console.log(a);
                        return a;
                    }
                }, {
                    field: 'faceToken',
                    title: '百度标识',
                    width: 200
                },
                {
                    field: 'faceProbability',
                    title: '置信度',
                    width: 50
                },
                {
                    field: 'age',
                    title: '年龄 ',
                    width: 50
                },
                {
                    field: 'beauty',
                    title: '颜值',
                    width: 50,
                    formatter: function (value, row, index) {
                        return value.substring(0, 5);
                    }
                },
                {
                    field: 'expressionType',
                    title: '表情',
                    width: 50,
                    formatter: function (value, row, index) {
                        if (value == 'none') {
                            value = "不笑";
                        } else if (value == 'smile') {
                            value = "微笑";
                        } else if (value == 'laugh') {
                            value = "大笑";
                        } else {
                            value = "未知";
                        }
                        return value;
                    }
                },
                {
                    field: 'faceShapeType',
                    title: '脸型',
                    width: 65,
                    formatter: function (value, row, index) {
                        if (value == 'square') {
                            value = "正方形";
                        } else if (value == 'triangle') {
                            value = "三角形";
                        } else if (value == 'oval') {
                            value = "椭圆";
                        } else if (value == 'heart') {
                            value = "心形";
                        } else if (value == 'round') {
                            value = "圆形";
                        } else {
                            value = "未知";
                        }
                        return value;
                    }
                },
                {
                    field: 'gender',
                    title: '性别',
                    width: 50,
                    formatter: function (value, row, index) {
                        if (value == 'male') {
                            value = "男性";
                        } else if (value == 'female') {
                            value = "女性";
                        } else {
                            value = "未知";
                        }
                        return value;
                    }
                },
                {
                    field: 'glassesType',
                    title: '眼镜类型',
                    width: 70,
                    formatter: function (value, row, index) {
                        if (value == 'none') {
                            value = "无眼镜";
                        } else if (value == 'common') {
                            value = "普通眼镜";
                        } else if (value == 'sun') {
                            value = "墨镜";
                        } else {
                            value = "未知";
                        }
                        return value;
                    }
                },
                {
                    field: 'raceType',
                    title: '肤色种类',
                    width: 70,
                    formatter: function (value, row, index) {
                        if (value == 'yellow') {
                            value = "黄种人";
                        } else if (value == 'white') {
                            value = "白种人";
                        } else if (value == 'black') {
                            value = "黑种人";
                        } else if (value == 'arabs') {
                            value = "阿拉伯人";
                        } else {
                            value = "未知";
                        }
                        return value;
                    }
                },
                {
                    field: 'openId',
                    title: '微信openid',
                    width: 110
                },
                {
                    field: 'nikeName',
                    title: '微信昵称',
                    width: 70,
                    formatter: function (value, row, index) {
                        var a = decodeURIComponent(value);
                        return a;
                    }
                }, {
                    title: '操作',
                    field: 'id',
                    align: 'center',
                    width: 130,
                    events: operateEvents,
                    formatter: genderOpt
                }]
        });
    }
    function reLoad() {
        $('#exampleTable').bootstrapTable('refresh');
    }
    //自定义列内容
    function genderOpt() {
        return [
            '<a class="btn btn-primary btn-sm" id="edit" href="javascript:void(0)" title="编辑">',
            '<i class="fa fa-edit"></i>',
            '</a>  ',
            '<a class="btn btn-primary btn-sm" id="remove" href="javascript:void(0)" title="删除">',
            '<i class="fa fa-remove"></i>',
            '</a>'
        ].join('');
    }

    //自定义列内容事件
    window.operateEvents = {
        'click #edit': function (e, value, row, index) {
            editData(row);
        },
        'click #remove': function (e, value, row, index) {
            remove(row.faceId);
        }
    };

    //删除操作
    function remove(id) {
        console.log(id);
        layer.confirm('确定要删除选中的内容？', {
            btn: ['确定', '取消']
        }, function () {
            $.ajax({
                url: prefix + "bdface/remove",
                type: "post",
                data: {
                    'id': id
                },
                success: function (r) {
                    if (r.code == 0) {
                        layer.msg("删除成功", {icon: 1});
                        reLoad();
                    } else {
                        layer.msg(r.msg, {icon: 0});
                    }
                }
            });
        })
    }

    //弹框保存按钮点击事件
    $("#btn_add_update_submit").off().on('click', function () {
        var faceProbability = $('#faceProbability').val(),
            age = $('#age').val(),
            beauty = $('#beauty').val(),
            expressionType = $('#expressionType').val(),
            faceShapeType = $('#faceShapeType').val(),
            gender = $('#gender').val(),
            glassesType = $('#glassesType').val(),
            raceType = $('#raceType').val();
            faceToken = $('#faceToken').val();

        $.ajax({
            url: prefix + 'bdface/update',
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            data: {
                faceToken:faceToken,
                faceProbability: faceProbability,
                age: age,
                beauty: beauty,
                expressionType: expressionType,
                faceShapeType: faceShapeType,
                gender: gender,
                glassesType: glassesType,
                raceType: raceType
            },
            //阻止深度序列化，向后台传送数组
            traditional: true,
            success: function (msg) {
                if (msg.success) {
                    layer.msg("更新成功", {icon: 0});
                } else {
                    layer.msg(msg.msg, {icon: 1, time: 1500});
                }
                reLoad();
            }
        })
    });

    //tr中编辑按钮点击事件
    function editData(row) {
        console.log(row.age);
        console.log("321132");
        //向模态框中传值
        $('#imagePath').val(row.imagePath);
        $('#faceToken').val(row.faceToken);
        $('#faceToken').attr("disabled", "disabled");
        $('#imagePath').attr("disabled", "disabled");
        $('#faceProbability').val(row.faceProbability);
        $('#age').val(row.age);
        $('#beauty').val(row.beauty);
        $('#expressionType').val(row.expressionType);
        $('#faceShapeType').val(row.faceShapeType);
        $('#gender').val(row.gender);
        $('#glassesType').val(row.glassesType);
        $('#raceType').val(row.raceType);
        $('#addAndUpdateLabel').text("修改信息");

        //显示模态窗口
        $('#addAndUpdate').modal({
            //点击ESC键,模态窗口即会退出。
            keyboard: true
        });
    }

    //删除按钮点击事件
    $("#btn_delete").on("click", function () {
        batchRemove();
    });
    //批量删除操作
    function batchRemove() {
        var rows = $('#exampleTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            layer.msg("请选择要删除的数据", {icon: 3});
            return;
        }
        layer.confirm("确认要删除选中的'" + rows.length + "'条数据吗?", {
            btn: ['确定', '取消']
        }, function () {
            var ids = new Array();
            $.each(rows, function (i, row) {
                ids[i] = row['faceId'];
            });
            console.log(ids);
            $.ajax({
                type: 'POST',
                data: {
                    "ids": ids
                },
                url: prefix + 'bdface/batchRemove',
                success: function (r) {
                    if (r.code == 0) {
                        layer.msg(r.msg, {icon: 1});
                        reLoad();
                    } else {
                        layer.msg(r.msg, {icon: 0});
                    }
                }
            });
        }, function () {
            layer.msg("取消操作", {icon: 1});
        });
    }
</script>
</body>
</html>