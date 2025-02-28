<%@ page import="cn.enncy.mall.pojo.User" %>

<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.File" %>
<%@ page import="cn.enncy.mall.utils.Security" %>
<%@ page import="cn.enncy.mybatis.core.SqlSession" %>
<%@ page import="cn.enncy.mall.mapper.UserMapper" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="cn.enncy.mall.service.UserService" %>
<%@ page import="cn.enncy.mybatis.core.ServiceFactory" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="cn.enncy.mall.pojo.BaseObjectUtils" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="cn.enncy.mall.annotaion.Info" %>

<style>
    .no-avatar{
        width: 64px;
        height: 64px;
        border: 2px dotted #e5e5e5;
        border-radius: 4px;

    }
</style>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp"/>
<jsp:include page="/common/navigation.jsp"/>
<%
    User user = (User) session.getAttribute("user");
%>
<div class="container  p-lg-5 mt-lg-5 mb-lg-5  p-md-2 mt-md-2 mb-md-2 d-flex justify-content-center  flex-lg-nowrap flex-wrap ">

    <jsp:include page="navigation.jsp"/>

    <form method="POST" class="d-flex flex-wrap  card p-4  col-lg-10 col-md-11 col-12 mb-0">

        <div class="  col-12">
            <div class="d-flex " style="white-space: nowrap">
                <div class="col-2 text-center" data-bs-toggle="modal" data-bs-target="#upload"
                     style="cursor: pointer">
                    <% if (user.getAvatar() == null || user.getAvatar().equals("null")) { %>
                    <svg   xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                         fill="currentColor"
                         class="bi bi-person-fill no-avatar"
                         viewBox="0 0 16 16">
                        <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"></path>
                    </svg>

                    <% } else { %>
                    <img src="${sessionScope.user.avatar}" width="64" height="64" class="rounded mx-auto d-block"
                         alt="${sessionScope.user.avatar}">
                    <% } %>
                </div>
                <div class="col-4">
                    <h5 class="card-title">${sessionScope.user.nickname}
                    </h5>
                    <h6 class="card-subtitle mb-2 text-muted">${sessionScope.user.profile}
                    </h6>
                </div>
            </div>
        </div>
        <div class="card mt-5 col-12">
            <div class="card-body">
                <h5 class="card-title">个人信息设置</h5>
            </div>
            <div class="p-4">
                <%
                    // 获取所有属性
                    List<Field> allFields = BaseObjectUtils.getAllFields(user.getClass());
                    // 获取属性值
                    Map<String, Object> valuesMap = BaseObjectUtils.getValuesMap(user);
                    // 去掉禁止的属性, 遍历显示信息
                    for (Field field : allFields) {
                        // 属性名
                        String name = field.getName();
                        // 属性值
                        Object value = valuesMap.get(field.getName());
                        Info info = field.getAnnotation(Info.class);
                %>

                <div class="mb-3 col-12" style="display: <%=info.disabled()?"none":"display"%>">
                    <label for="input<%=name%>"><%=info.value()%>
                    </label>
                    <input name="<%=name%>" type="text" class="form-control" id="input<%=name%>" value="<%=value%>">
                </div>

                <% } %>

                <div class=" col-12">
                    <button type="submit" class="btn btn-primary w-25 float-end">修改</button>
                </div>


            </div>

        </div>


        <!-- Modal -->
        <div class="modal fade" id="upload" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">上传头像</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div style="text-align: center">
                            <input class="form-control" type="file" accept=".png,.jpg" onchange="upload(this)">
                            <img id="uploadImage" style="max-width: 400px" class="m-2" src="<%=user.getAvatar()%>">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">上传</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<jsp:include page="/common/footer.jsp"/>
<script>
    function upload(el) {
        let formData = new FormData();
        let file = el.files.item(0)
        console.log("upload", file)
        formData.append('image', file); //添加图片信息的参数
        $.ajax({
            url: '/image/upload?name=' + file.name,
            data: formData,
            method: 'post',
            processData: false, // 告诉jQuery不要去处理发送的数据
            contentType: false, // 告诉jQuery不要去设置Content-Type请求头
            dataType: "json",
            success(r) {
                console.log(r)
                if (r.status) {
                    $("#inputavatar").val(r.data);
                    $("#uploadImage").attr("src", r.data)
                }
            },
            error() {
                alert("上传失败!")
            }
        })
    }
</script>