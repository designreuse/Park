<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Upload photo">
    <jsp:attribute name="body">
        <h1>Photo</h1>
        <div class="row">
            <div class="col-lg-3"></div>
            <div class="col-md-6">
                <form>
                    <div class="form-group">
                        <label id="upload-status" class="control-label"></label>
                        <div class="progress hidden">
                            <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:0%">
                                <span class="sr-only">70% Complete</span>
                            </div>
                        </div>
                        <cl:upload fieldName="image_id" resourceType="auto" callback="/resources/cloudinary_cors.html" multiple="false" extraClasses="center-block btn btn-success"/>
                    </div>
                </form>
            </div>
            <div class="col-lg-3"></div>
        </div>

         <div id="preview">

         </div>
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="<c:url value="/resources/js/jquery.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.ui.widget.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.fileupload.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.cloudinary.js" />" type="text/javascript"></script>

        <script type="text/javascript">
            $.cloudinary.config({ cloud_name: 'gnom-7-cloud', api_key: '994662958897139'})

            $(document).ready(function() {
                $(".cloudinary-fileupload")
                        .cloudinary_fileupload({
                            start: function (e) {
                                $('.progress').removeClass('hidden');
                                $('#upload-status').text('Loading...');
                                $('.form-group').removeClass('has-success');
                                $('.form-group').removeClass('has-error');
                                $('.form-group').addClass('has-warning');
                                $('.progress-bar').addClass('progress-bar-striped');
                                $('.progress-bar').addClass('active');
                                $('.progress-bar').removeClass('progress-bar-success');
                                $('.progress-bar').removeClass('progress-bar-danger');
                                $('.progress-bar').width('0%');
                            },
                            progress: function (e, data) {
                                $('.progress-bar').width(data.loaded / data.total * 100 + '%');
                            },
                            fail: function (e, data) {
                                $('#upload-status').text('Load failed');
                                $('.form-group').removeClass('has-warning');
                                $('.form-group').addClass('has-error');
                                $('.progress-bar').removeClass('active');
                                $('.progress-bar').removeClass('progress-bar-striped');
                                $('.progress-bar').addClass('progress-bar-danger');
                            }
                        })
                        .off("cloudinarydone").on("cloudinarydone", function (e, data) {
                            $.get('photo/upload?photo_id=' + data.result.public_id, function (data, status) {
                                console.log(data);
                                console.log(status);
                            })

                            $('#upload-status').text('Loaded successful');
                            $('.form-group').removeClass('has-warning');
                            $('.form-group').addClass('has-success');
                            $('.progress-bar').removeClass('active');
                            $('.progress-bar').removeClass('progress-bar-striped');
                            $('.progress-bar').addClass('progress-bar-success');

                            $('#preview').append($.cloudinary.image(data.result.public_id, {
                                format: data.result.format, width: 150, height: 150, crop: "fit"}));
                            $('#preview').children().last().wrap($('<a>', { href: data.result.url, target: '_blank' }));
                        })



            });
        </script>
    </jsp:attribute>
</t:wrapper>
