<%@ page import="com.liferay.commerce.product.util.CPDefinitionHelper" %>
<%@ page import="com.liferay.commerce.product.model.*" %>
<%@ include file="/META-INF/resources/init.jsp" %>

<%
	TabbedRendererDisplayContext tabbedRendererDisplayContext = (TabbedRendererDisplayContext)request.getAttribute("tabbedRendererDisplayContext");
	CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);

	CPCatalogEntry cpCatalogEntry = cpContentHelper.getCPCatalogEntry(request);
	long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();
	CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);

	List<CPDefinitionSpecificationOptionValue> cableDetailsItems = tabbedRendererDisplayContext.getSpecificationsByGroup(cpDefinitionId, "cable-details");
	List<CPMedia> cpAttachmentFileEntries = cpContentHelper.getCPAttachmentFileEntries(cpDefinitionId, themeDisplay);

	String addToCartId = PortalUtil.generateRandomKey(request, "add-to-cart");

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
				<span class="product-numbers">
						<div>Catalog Number: <%= (cpSku == null) ? StringPool.BLANK : HtmlUtil.escape(cpSku.getSku()) %></div>
						<div>UPS:  <%= (cpSku == null) ? StringPool.BLANK : HtmlUtil.escape(cpSku.getManufacturerPartNumber()) %></div>
				</span>

				<h2 class="product-header-title"><%= HtmlUtil.escape(cpCatalogEntry.getName()) %></h2>

			</header>
		</div>
		<div class="col-md-2 col-xs-12"></div>
	</div>

	<div class="row">
		<div class="col-md-2 col-xs-12"></div>
		<div class="col-md-8 col-xs-12">
			<liferay-ui:tabs
					names='<%= "overview,product-information,specifications,colorspec,tools,documents" %>'
					param="tabs2"
					refresh="<%= false %>"
					type="tabs"
			>
				<liferay-ui:section>
					<%@ include file="overview.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="product_information.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="specifications.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="color.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="tools_and_configuration.jspf" %>
				</liferay-ui:section>

				<liferay-ui:section>
					<%@ include file="documents.jspf" %>
				</liferay-ui:section>

			</liferay-ui:tabs>
		</div>
		<div class="col-md-2 col-xs-12"></div>
	</div>

	<div class="row">
		<div class="col-md-2 col-xs-12"></div>
		<div class="col-md-8 col-xs-12">
			<div class="btn-group">
				<div class="btn-group-item">
					<button class="btn btn-primary" type="submit">Add to Project</button>
				</div>
				<div class="btn-group-item">
					<button class="btn btn-primary" type="submit">Add to Favorites</button>
				</div>
				<div class="btn-group-item">
					<button class="btn btn-primary" type="submit">Request Information</button>
				</div>
				<div class="btn-group-item">
					<button class="btn btn-secondary" type="button">&#x2193; BIM</button>
				</div>
				<div class="btn-group-item">
					<button class="btn btn-secondary" type="button">&#x2193; Cut Sheet</button>
				</div>

			</div>

		</div>
		<div class="col-md-2 col-xs-12"></div>
	</div>

</div>