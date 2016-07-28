<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Home">
    <jsp:attribute name="body">

        <div id="widget-container" style="width: auto; height: auto"></div>

    </jsp:attribute>
    <jsp:attribute name="scripts">

    <script src="<c:url value="/resources/js/jquery.js" />" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/jquery.cloudinary.js" />" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/jquery.ui.widget.js" />" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/jquery.fileupload.js" />" type="text/javascript"></script>
    <script>$.cloudinary.config({ cloud_name: 'gnom-7-cloud', api_key: '994662958897139'});</script>

<script src="//widget.cloudinary.com/global/all.js" type="text/javascript"></script>

        <script>
            var widget = cloudinary.createUploadWidget(
                    { cloud_name: 'gnom-7-cloud', upload_preset: 'sample_7eb3c60c0a',
                        theme: 'white', keep_widget_open: 'true', inline_container: '#widget-container'},
                    function(error, result) {
                        console.log(error, result);

                        $.post('submit', {photoUrl: result[0].url,
                        "${_csrf.parameterName}": "${_csrf.token}"}, function() {

                        });


                    });
            widget.open();
        </script>

    </jsp:attribute>
</t:wrapper>
