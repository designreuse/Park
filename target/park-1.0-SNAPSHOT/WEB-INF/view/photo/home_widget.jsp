<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Home">
    <jsp:attribute name="body">

<!--<a href="#" id="upload_widget_opener">Upload multiple images</a>-->

        <div id="widget-container" style="width: auto; height: auto"></div>

    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="<c:url value="/resources/js/jquery.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.cloudinary.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.ui.widget.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/jquery.fileupload.js" />" type="text/javascript"></script>

<!--        <script type="text/javascript">

            $.cloudinary.config({ cloud_name: 'gnom-7-cloud', api_key: '994662958897139'});

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
        </script>-->





<script src="//widget.cloudinary.com/global/all.js" type="text/javascript"></script>

        <script>
            $.cloudinary.config({ cloud_name: 'gnom-7-cloud', api_key: '994662958897139'});
            var widget = cloudinary.createUploadWidget(
                    { cloud_name: 'gnom-7-cloud', upload_preset: 'sample_7eb3c60c0a',
                        cropping: 'server', 'folder': 'user_photos', theme: 'white',
                        show_powered_by: 'false', keep_widget_open: 'true',
                        inline_container: '#widget-container'},
                    function(error, result) {console.log(error, result)});

            widget.open();
        </script>

    </jsp:attribute>
</t:wrapper>
