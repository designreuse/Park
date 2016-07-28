<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="messages" />


<t:wrapper title="${title}">
        <link href="<c:url value="/resources/css/photo.css" var="photoStyle"/>" rel="stylesheet" />
    <jsp:attribute name="body">
        <c:if test="${empty albumList}">
            <div class="panel panel-warning" style="margin-top: 20px">
                <div class="panel-body" style="text-align: center;">
                    <strong>${noAlbums}</strong>
                </div>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-2">
                <button type="button" id="add-album" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                    ${addAlbum}
                </button>
            </div>
            <div class="col-md-5"></div>
        </div>

        <div class="flex-container">
        <c:forEach items="${albumList}" var="album">
            <div class="thumbnail">
                <div class="album-thumb">
                    <h4>${album.name}</h4>
                    <div class="toolbar">
                        <a href="<c:url value="/albums/${album.id}"/>" class="btn btn-info" rel="tooltip" title="${editLabel}">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                        </a>
                        <a href="#" data-albumid="${album.id}" class="btn btn-danger" rel="tooltip" title="${deleteLabel}">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
                <div class="deleted">
                    <h4>${deleted}</h4>
                    <p>${reviveLabel}</p>
                    <div class="toolbar">
                        <a href="#"data-albumid="${album.id}" class="btn btn-info restore" rel="tooltip" title="${restoreLabel}">
                            <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
                <a href="<c:url value="/albums/show/${album.id}"/>" title="${startSlideshow}">
                    <img src="<c:url value="http://res.cloudinary.com/itraphotocloud/image/upload/c_thumb,h_150,w_150/npvp2apyuhm81higa7vj.jpg"/>">
                </a>
                <div class="album-title" style="text-align: center">
                    <h4>${album.name}</h4>
                </div>
            </div>
        </c:forEach>
        </div>

    </jsp:attribute>
    <jsp:attribute name="scripts">

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">${addAlbum}</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <%--<label for="exampleInputEmail1">Email address</label>--%>
                            <input type="email" class="form-control" id="album-name" placeholder="${albumTitle}">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">${cancel}</button>
                        <button type="button" class="btn btn-primary" id="create-button">${create}</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <script type="text/javascript">

            $(document).ready(function () {

                $("[rel='tooltip']").tooltip();

                $('.thumbnail').hover(
                        function(){
                            $(this).find('.album-thumb').slideDown(250); //.fadeIn(250)
                            $(this).find('.album-title').children('h4').css('color', 'white');
                        },
                        function(){
                            $(this).find('.album-thumb').slideUp(250); //.fadeOut(205)
                            $(this).find('.album-title').children('h4').css('color', 'black');
                        }
                );

                // delete album
                $('.btn-danger').on('click', function () {
                    var button = $(this);
                    $.post('/albums/delete', {album_id: button.data('albumid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        var caption = thumb.find('.album-thumb');
                        caption.hide();
                        caption.removeClass('album-thumb');
                        caption.addClass('album-thumb-del');
                        thumb.find('.deleted').fadeIn(250);
                    });
                });

                // restore album
                $('.restore').on('click', function () {
                    var button = $(this);
                    $.post('/albums/restore', {album_id: button.data('albumid'),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        var thumb = button.closest('.thumbnail');
                        thumb.find('.deleted').fadeOut(250);
                        var caption = thumb.find('.album-thumb-del');
                        caption.removeClass('album-thumb-del');
                        caption.addClass('album-thumb');
                    });
                });

                $('#create-button').on('click', function () {
                    if ($(this).closest('.modal-dialog').find('input').val().length < 1) {
                        $(this).closest('.modal-dialog').find('.form-group').addClass('has-error');
                        return false;
                    }
                    $(this).closest('.modal-dialog').find('.form-group').removeClass('has-error');


                    $.post('/albums/create', {album: $('#album-name').val(),
                    ${_csrf.parameterName}: "${_csrf.token}"},
                    function (data, status) {
                        console.log(data);
                        window.location.href = '/albums/';
                    });
                });




            });

        </script>
    </jsp:attribute>
</t:wrapper>