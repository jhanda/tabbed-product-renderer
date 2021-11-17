<%@ page import="com.liferay.commerce.product.content.util.CPContentHelper" %>
<%@ page import="com.liferay.commerce.product.content.constants.CPContentWebKeys" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="com.liferay.commerce.product.catalog.CPCatalogEntry" %>
<%@ page import="com.liferay.asset.kernel.model.AssetCategory" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.commerce.product.model.CPDefinitionSpecificationOptionValue" %>
<%@ page import="com.liferay.commerce.product.catalog.CPMedia" %>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ include file="/META-INF/resources/init.jsp" %>

<%
	CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
	NumberFormat numberFormat = NumberFormat.getInstance();
	CPCatalogEntry cpCatalogEntry = cpContentHelper.getCPCatalogEntry(request);
	long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();

	List<CPMedia> cpAttachmentFileEntries = cpContentHelper.getCPAttachmentFileEntries(cpDefinitionId, themeDisplay);
%>

<%@ include file="styles.jspf" %>

<div class="mb-5 product-detail" id="<portlet:namespace /><%= cpDefinitionId %>ProductContent">
	<div class="row">
		<div class="col-md-2 col-xs-12"></div>
		<div class="col-md-8 col-xs-12">
			<header class="product-header">
				<commerce-ui:compare-checkbox
						componentId="compareCheckbox"
						CPDefinitionId="<%= cpDefinitionId %>"
				/>

				<span class="label label-inverse-info">
					<%
						for (AssetCategory assetCategory: planTypeCategories){
					%>
						<span class="label-item label-item-expand"><%= assetCategory.getTitle(locale)%></span>
					<%
						}
					%>
				</span>

				<h2 class="product-header-title"><%= HtmlUtil.escape(cpCatalogEntry.getName()) %></h2>
			</header>

			<p class="mt-3 procuct-description"><%= cpCatalogEntry.getDescription() %></p>

			<div>Plan Status: <span class="<%= textColor %> font-weight-bold"><%= planStatus%></span></div>
			<div>
				<p class="mb-0">Created: <strong><%= tabbedSpecGroupRendererDisplayContext.getCreatedDateAsString(cpDefinitionId) %></strong></p>
				<p class="mb-0">Modified: <strong><%= tabbedSpecGroupRendererDisplayContext.getModifiedDateAsString(cpDefinitionId) %></strong></p>
				<br>
			</div>

			<div class="progress">
				<div
					class="progress-bar <%= bgColor %> >"
					role="progressbar"
					style="width: <%= percentMessages %>%"
					aria-valuenow="10"
					aria-valuemin="0"
					aria-valuemax="100"
				>
				</div>
			</div>
			<div>
				<div style="float: left;"><dt>Messages sent:</dt><dd><%= numberFormat.format(sentMessages) %></dd></div>
				<div style="float: right;"><dt>Messages in plan:</dt><dd> <%= numberFormat.format(contractedMessages) %></dd></div>
			</div>
		</div>

		<div class="col-md-2 col-xs-12"></div>

	</div>


	<div class="row">
		<div class="col-md-2 col-xs-12"></div>
		<div class="col-md-8 col-xs-12">
			<liferay-ui:tabs
					names='<%= "language,premium,sscbi,fed-contracting,cross-walk,files" %>'
					param="tabs2"
					refresh="<%= false %>"
					type="pills"
			>
				<liferay-ui:section>
					<%@ include file="specifications.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="tools_and_configuration.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="color.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="product_information.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="overview.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="documents.jspf" %>
				</liferay-ui:section>

			</liferay-ui:tabs>
		</div>
		<div class="col-md-2 col-xs-12"></div>
	</div>
</div>