<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="messages" />

<fmt:message key="message.error404" var="errorText"/>
<fmt:message key="message.error404text" var="errorTextExtra"/>

<t:errorwrapper errorName="404" errorText="${errorText}">
    <jsp:attribute name="errorTextExtra">
        ${errorTextExtra}
    </jsp:attribute>
</t:errorwrapper>