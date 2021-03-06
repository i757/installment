<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <title>富凯分期</title>
    <jsp:include page="../../head.jsp"/>
</head>

<body>
<div id="wrapper">

    <!--/. NAV TOP  -->
    <jsp:include page="../../nav.jsp"/>

    <div id="page-wrapper">
        <div class="header">
            <h1 class="page-header">
                全部用户 <small>欢迎光临富凯分期</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/success">主页</a></li>
                <li><a href="${pageContext.request.contextPath}/success">用户管理</a></li>
                <li class="active">列表</li>
            </ol>

        </div>
        <div id="page-inner">

            <!-- /. ROW  -->

            <div class="row">
                <div class="col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <div class="tab-content">
                                <form class="form-inline">
                                    <div class="form-group">
                                        <input type="text" id="keyWord" class="form-control" id="exampleInputEmail3" placeholder="请输入用户信息">
                                    </div>
                                    <button type="button" id="search" class="btn btn-default" onclick="createDate()">搜 索</button>
                                </form>
                                <div class="tab-pane fade active in" id="create">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>身份证号</th>
                                                <th>贷款本金</th>
                                                <th>执行利率</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbody"></tbody>
                                    </table>
                                </div>
                                <div class="tab-pane fade" id="assent">
                                </div>
                                <div class="tab-pane fade" id="against">
                                </div>
                            </div>
                            <div class="col-sm-2"></div>
                            <div class="col-sm-8" style="text-align: center">
                                <div id="page" class="page_div"></div>
                            </div>
                            <div class="col-sm-2"></div>
                        </div>
                    </div>
                </div>
            </div>

            <footer><p>Copyright &copy; 2019.Company name All rights reserved.<a target="_blank" href="http://www.i757.com/">富凯分期</a></p>


            </footer>
        </div>
        <!-- /. PAGE INNER  -->
    </div>
    <!-- /. PAGE WRAPPER  -->
</div>

<script>
    var page = 1;
    $(document).ready(function () {
        if($("#userId").val() == ''){
            window.location.href='${pageContext.request.contextPath}/index.jsp';
        }else {
            createDate();
        }
    });
    function showList(list) {
        $("#tbody").html("");
        if(list.length > 0){
            var total = 0;
            $.each(list,function (index,item) {
                $("#tbody").append("<tr><th>" + (index+1) + "</th><td>" + item.name + "</td><td>" + item.mobilePhone + "</td><td>" + item.idCard
                    +"</td><td>" + item.installmentAmount +"</td><td>" + item.interestRate + "</td>" +
                    "<td><a onclick=modifyInfo(\""+item.installmentEntityId+"\")>修改</a>|<a onclick=detailInfo(\""+item.installmentEntityId+"\")>详情</a>|<a onclick=deleteInfo(\""+item.installmentEntityId+"\")>删除</a></td></tr>");
                total = total + item.installmentAmount;
            });
            $("#tbody").append("<tr><th colspan='4'>总计：</th><td>"+total+"</td><td></td></tr>");
        }else{
            $("#tbody").html("没有数据");
        }
    }

    function detailInfo(id){
        window.location.href = "${pageContext.request.contextPath}/deatil?id="+id;
    }

    function modifyInfo(id){
        window.location.href = "${pageContext.request.contextPath}/edit?id="+id;
    }

    function callbackDel(data){
        if(data.retCode == 200){
            msg(data.retMsg);
            createDate();
        }else{
            msg(data.retMsg);
        }
    }

    function deleteInfo(id){
        layer.confirm('确定要删除这条数据吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            getRequest("${pageContext.request.contextPath}/user/deleteInfo?id="+id,callbackDel);
        });
    }

    var size = 20;

    function totalPage(count){
        if(count % size ==0){
            return count/size;
        }else{
            return Math.ceil(count/size);
        }
    }

    function callback1(data) {
        if(data.userList.length > 0){
            showList(data.userList);
            $("#page").paging({
                pageNo: page,
                totalPage: totalPage(data.count),
                totalSize: data.count,
                callback: function(num) {
                    page = num;
                    createDate();
                }
            });
        }else{
            $("#tbody").html("没有数据");
        }
    }

    function createDate() {
        var keyWord = $("#keyWord").val();
        getRequest("${pageContext.request.contextPath}/user/queryUser?page="+page+"&size="+size+"&keyWord="+keyWord,callback1);
    }



</script>

</body>

</html>