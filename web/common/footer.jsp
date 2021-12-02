<%@ page import="cn.enncy.mall.constant.ServiceMapping" %>
<%@ page import="cn.enncy.mybatis.core.ServiceFactory" %>
<%@ page import="cn.enncy.mall.service.TagService" %>
<%@ page import="cn.enncy.mall.pojo.Tag" %>
<%@ page import="cn.enncy.mall.service.impl.TagServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    TagService tagService = ServiceFactory.resolve(TagServiceImpl.class);
%>

</main>

<footer class="container py-5" style="background-color: white">
    <div class="row">
        <div class="col-12 col-md">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="d-block mb-2" role="img" viewBox="0 0 24 24" focusable="false"><title>Product</title><circle cx="12" cy="12" r="10"></circle><path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"></path></svg>
            <small class="d-block mb-3 text-muted">© 2021 mall</small>
        </div>
        <div class="col-6 col-md">
            <h5>商品分类</h5>
            <ul class="list-unstyled text-small">
                <% for( Tag tag :  tagService.findByPages(0,10)){ %>
                <li><a class="text-muted" href="/goods?tag=<%=tag.getName()%>"><%=tag.getName()%></a></li>
                <% } %>

            </ul>
        </div>
        <div class="col-6 col-md">
            <h5>友情链接</h5>
            <ul class="list-unstyled text-small">
                <li><a class="text-muted" href="https://www.jd.com/" target="_blank">京东</a></li>
                <li><a class="text-muted" href="https://www.taobao.com/" target="_blank">淘宝</a></li>
                <li><a class="text-muted" href="https://www.pinduoduo.com/" target="_blank">拼多多</a></li>
                <li><a class="text-muted" href="https://www.suning.com/" target="_blank">苏宁易购</a></li>
                <li><a class="text-muted" href="https://www.vip.com/" target="_blank">唯品会</a></li>
                <li><a class="text-muted" href="http://gz.jumei.com/" target="_blank">聚美优品</a></li>
            </ul>
        </div>

        <div class="col-6 col-md">
            <h5>关于</h5>
            <ul class="list-unstyled text-small">
                <li><a class="text-muted" href="#">网站</a></li>
                <li><a class="text-muted" href="#">地址</a></li>
                <li><a class="text-muted" href="#">隐私</a></li>
                <li><a class="text-muted" href="#">团队成员</a></li>
            </ul>
        </div>
    </div>
</footer>

<script src="https://v5.bootcss.com/docs/5.1/dist/js/bootstrap.bundle.min.js"  ></script>

</body>
</html>


