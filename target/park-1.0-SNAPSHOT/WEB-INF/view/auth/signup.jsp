<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:wrapper title="Sign up">
    <jsp:attribute name="body">
        <div class="row">
            <div class="col-md-4" style="margin-top: 100px"></div>
            <div class="col-md-4" style="margin-top: 100px">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <sf:form action="/signup" method="post" modelAttribute="userDto">
                            <c:if test="${message != null}">
                                <div class="alert alert-success">
                                    <p>${message}</p>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <sf:label path="email" title="email" for="email">Email</sf:label>
                                <sf:input path="email" cssClass="form-control" required="required" />
                            </div>
                            <div class="form-group">
                                <sf:label path="password" title="password" for="password">Password</sf:label>
                                <sf:password path="password" cssClass="form-control" required="required"/>
                            </div>
                            <div class="form-group">
                                <sf:label path="confirmPassword" title="confirmPassword" for="confirmPassword">Confirm Password</sf:label>
                                <sf:password path="confirmPassword" cssClass="form-control" required="required"/>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="submit" value="Sign up" class="btn btn-default center-block"/>
                            <a href="/login" class="btn right-button">Sign in</a>
                        </sf:form>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </jsp:attribute>
    <jsp:attribute name="scripts">

    </jsp:attribute>
</t:wrapper>