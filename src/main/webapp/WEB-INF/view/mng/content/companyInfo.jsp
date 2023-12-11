<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/mng/layout/mngHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>

    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-5 align-self-center">
                    <h4 class="page-title">회사 소개</h4>
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="row">
                <div class="col-12">
                    <form action="/mng/content/register" method="post">
                        <%-- CK Editor --%>
                        <input type="number" name="type" value="0" hidden />
                        <div id="container">
                            <textarea id="editor" name="content"></textarea>
                        </div>
                        <button onclick="location.href='/mng/company/info'" class="btn btn-secondary">취소</button>
                        <button class="btn btn-primary" type="submit">등록</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
<script>
    ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
</script>
<style>
    #container {
        width: 100%;
    }
</style>
</body>
</html>
<%@ include file="/WEB-INF/view/mng/layout/mngFooter.jsp" %>