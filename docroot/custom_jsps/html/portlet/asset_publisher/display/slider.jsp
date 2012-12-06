
<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/asset_publisher/init.jsp" %>

<%

List results = (List)request.getAttribute("view.jsp-results");

int assetEntryIndex = ((Integer)request.getAttribute("view.jsp-assetEntryIndex")).intValue();

AssetEntry assetEntry = (AssetEntry)request.getAttribute("view.jsp-assetEntry");
AssetRendererFactory assetRendererFactory = (AssetRendererFactory)request.getAttribute("view.jsp-assetRendererFactory");
AssetRenderer assetRenderer = (AssetRenderer)request.getAttribute("view.jsp-assetRenderer");

boolean show = ((Boolean)request.getAttribute("view.jsp-show")).booleanValue();

request.setAttribute("view.jsp-showIconLabel", true);

String title = (String)request.getAttribute("view.jsp-title");

if (Validator.isNull(title)) {
	title = assetRenderer.getTitle(locale);
}

PortletURL viewFullContentURL = renderResponse.createRenderURL();

viewFullContentURL.setParameter("struts_action", "/asset_publisher/view_content");
viewFullContentURL.setParameter("assetEntryId", String.valueOf(assetEntry.getEntryId()));
viewFullContentURL.setParameter("type", assetRendererFactory.getType());

if (Validator.isNotNull(assetRenderer.getUrlTitle())) {
	if (assetRenderer.getGroupId() != scopeGroupId) {
		viewFullContentURL.setParameter("groupId", String.valueOf(assetRenderer.getGroupId()));
	}

	viewFullContentURL.setParameter("urlTitle", assetRenderer.getUrlTitle());
}

String summary = StringUtil.shorten(assetRenderer.getSummary(locale), abstractLength);
String viewURL = null;


if (viewInContext) {
	String viewFullContentURLString = viewFullContentURL.toString();

	viewFullContentURLString = HttpUtil.setParameter(viewFullContentURLString, "redirect", currentURL);

	viewURL = assetRenderer.getURLViewInContext(liferayPortletRequest, liferayPortletResponse, viewFullContentURLString);

	viewURL = HttpUtil.setParameter(viewURL, "redirect", currentURL);
}
else {
	viewURL = viewFullContentURL.toString();
}

if (Validator.isNull(viewURL)) {
	viewURL = viewFullContentURL.toString();
}

String viewURLMessage = viewInContext ? assetRenderer.getViewInContextMessage() : "read-more-x-about-x";

viewURL = _checkViewURL(viewURL, currentURL, themeDisplay);
%>
<li>

<c:if test="<%= show && assetRenderer.hasViewPermission(permissionChecker) %>">
	<div class="news-slider">
		<liferay-util:include page="/html/portlet/asset_publisher/asset_actions.jsp" />

		<h4>
			<c:choose>
				<c:when test="<%= Validator.isNotNull(viewURL) %>">
					<a href="<%= viewURL %>"><%= HtmlUtil.escape(title) %></a>
				</c:when>
				<c:otherwise>
					<%= HtmlUtil.escape(title) %>
				</c:otherwise>
			</c:choose>
		</h4>
		
		<%
		String path = assetRenderer.render(renderRequest, renderResponse, AssetRenderer.TEMPLATE_ABSTRACT);
		//String path = assetRenderer.render(renderRequest, renderResponse, "abstract");
		//String path =  "/html/portlet/journal/asset/slider.jsp";
		request.setAttribute(WebKeys.ASSET_RENDERER, assetRenderer);
		request.setAttribute(WebKeys.ASSET_PUBLISHER_ABSTRACT_LENGTH, abstractLength);
		%>
			
		<p>
			<c:choose>
				<c:when test="<%= path == null %>">
					<%= summary %>
				</c:when>
				<c:otherwise>
					<liferay-util:include page="/html/portlet/journal/asset/slider.jsp" portletId="<%= assetRendererFactory.getPortletId() %>" />
				</c:otherwise>
			</c:choose>

			<c:if test="<%= Validator.isNotNull(viewURL) %>">
				<div class="asset-more">
					<a href="<%= viewURL %>"><liferay-ui:message arguments='<%= new Object[] {"aui-helper-hidden-accessible", HtmlUtil.escape(assetRenderer.getTitle(locale))} %>' key="<%= viewURLMessage %>" /> &raquo; </a>
				</div>
			</c:if>
			<div class="asset-metadata">
				<%@ include file="/html/portlet/asset_publisher/asset_metadata.jspf" %>
			</div>
		</p>
	</div>
	<div class="clear"><!-- --></div>

</c:if>
</li>