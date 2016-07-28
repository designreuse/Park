<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Edit">

    <jsp:attribute name="body">
        <div class="camera_wrap camera_white_skin">
            <c:forEach items="${album.getPhotos().getUrl()}" var="photoUrl">
                    <div data-src="${photoUrl}"></div>
        </c:forEach>
        </div>

        <div class="container" style="margin-top: 50px">
            <div class="row">
        <c:forEach items="${albumsList}" var="album">
            <div class="col-md-3">
                <div class="thumbnail">
                    <div data-src=${album.getPhotos().get(0).getUrl()}>
                </div>
            </div>
        </c:forEach>
            </div>
        </div>
        </div>
    </jsp:attribute>

    <jsp:attribute name="scripts">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js"></script>
    <script src="https://raw.githubusercontent.com/pixedelic/Camera/master/scripts/camera.min.js"></script>
    <link href="https://raw.githubusercontent.com/pixedelic/Camera/master/css/camera.css" rel="stylesheet" />

        <script type="text/javascript">
            $(document).ready(function () {
                jQuery('.camera_wrap').camera({
                    fx: ${album.getEffects()},
                    <c:if test="${album.random}">
                    slideOn: 'random',
                    </c:if>
                    time: ${album.getSpeed()},
                    transPeriod: ${album.getEffectSpeed()}
                });
            });
        </script>

    </jsp:attribute>

</t:wrapper>