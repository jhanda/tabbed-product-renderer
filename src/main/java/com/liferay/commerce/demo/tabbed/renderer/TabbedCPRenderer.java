package com.liferay.commerce.demo.tabbed.renderer;

import com.liferay.asset.kernel.service.AssetEntryLocalService;
import com.liferay.asset.kernel.service.AssetVocabularyLocalService;
import com.liferay.commerce.demo.tabbed.renderer.display.context.TabbedRendererDisplayContext;
import com.liferay.commerce.product.catalog.CPCatalogEntry;
import com.liferay.commerce.product.content.render.CPContentRenderer;
import com.liferay.commerce.product.service.CPDefinitionLocalService;
import com.liferay.commerce.product.service.CPDefinitionSpecificationOptionValueLocalService;
import com.liferay.commerce.product.service.CPOptionCategoryLocalService;
import com.liferay.commerce.product.service.CPSpecificationOptionLocalService;
import com.liferay.frontend.taglib.servlet.taglib.util.JSPRenderer;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.ResourceBundleUtil;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * @author Jeff Handa
 */
@Component(
        immediate = true,
        property = {
                "commerce.product.content.renderer.key=" + TabbedCPRenderer.KEY,
                "commerce.product.content.renderer.type=grouped",
                "commerce.product.content.renderer.type=simple",
                "commerce.product.content.renderer.type=virtual"
        },
        service = CPContentRenderer.class
)
public class TabbedCPRenderer implements CPContentRenderer{

    public static final String KEY = "tabbed-renderer";

    @Override
    public String getKey() {
        return KEY;
    }

    @Override
    public String getLabel(Locale locale) {
        ResourceBundle resourceBundle = ResourceBundleUtil.getBundle(
                "content.Language", locale, getClass());

        return LanguageUtil.get(resourceBundle, "tabbed-renderer");
    }

    @Override
    public void render(CPCatalogEntry cpCatalogEntry, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {

        TabbedRendererDisplayContext tabbedRendererDisplayContext =
                new TabbedRendererDisplayContext(httpServletRequest, _cpDefinitionLocalService,
                        _cpOptionCategoryLocalService, _cpSpecificationOptionLocalService,
                        _cpDefinitionSpecificationOptionValueLocalService,_assetEntryLocalService,
                        _assetVocabularyLocalService);

        httpServletRequest.setAttribute("tabbedRendererDisplayContext", tabbedRendererDisplayContext);

        _jspRenderer.renderJSP(
                _servletContext, httpServletRequest, httpServletResponse,
                "/render/view.jsp");
    }

    @Reference(
            target = "(osgi.web.symbolicname=com.liferay.commerce.demo.tabbed.renderer)"
    )
    private ServletContext _servletContext;

    @Reference
    private JSPRenderer _jspRenderer;

    @Reference
    private CPDefinitionLocalService _cpDefinitionLocalService;

    @Reference
    private CPOptionCategoryLocalService _cpOptionCategoryLocalService ;

    @Reference
    private CPSpecificationOptionLocalService _cpSpecificationOptionLocalService;

    @Reference
    private CPDefinitionSpecificationOptionValueLocalService _cpDefinitionSpecificationOptionValueLocalService;

    @Reference
    private AssetEntryLocalService _assetEntryLocalService;

    @Reference
    private AssetVocabularyLocalService _assetVocabularyLocalService;

}