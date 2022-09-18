<%@ page import="com.liferay.docs.guestbook.service.GuestbookEntryLocalServiceUtil" %>
<%@ page import="com.liferay.docs.guestbook.model.GuestbookEntry" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.service.ServiceContext" %>
<%@ include file="../init.jsp" %>

<portlet:renderURL var="viewURL">
    <portlet:param name="mvcPath" value="/guestbook/view.jsp"></portlet:param>
</portlet:renderURL>

<portlet:actionURL name="addEntry" var="addEntryURL" />

<%

//    ServiceContext renderRequest = null;

    long entryId = ParamUtil.getLong(renderRequest, "entryId");

    GuestbookEntry entry = null;
    if (entryId > 0) {
        entry = GuestbookEntryLocalServiceUtil.getGuestbookEntry(entryId);
    }

    long guestbookId = ParamUtil.getLong(renderRequest, "guestbookId");

%>
<aui:form action="<%= addEntryURL %>" name="<portlet:namespace />fm">
    <liferay-ui:header
            backURL="<%= viewURL.toString() %>"
            title="<%= entry == null ? "Add Entry" : entry.getName() %>"
    />
    <aui:model-context bean="<%= entry %>" model="<%= GuestbookEntry.class %>" />

    <aui:fieldset>

        <aui:input name="name" />
        <aui:input name="email" />
        <aui:input name="message" />
        <aui:input name="entryId" type="hidden" />
        <aui:input name="guestbookId" type="hidden" value='<%= entry == null ? guestbookId : entry.getGuestbookId() %>'/>

    </aui:fieldset>
    <liferay-asset:asset-categories-error /> <liferay-asset:asset-tags-error />

    <liferay-ui:panel defaultState="closed" extended="<%= false %>" id="entryCategorizationPanel" persistState="<%= true %>" title="categorization">

    <aui:fieldset>
        <liferay-asset:asset-categories-selector className="<%= GuestbookEntry.class.getName() %>" classPK="<%= entryId %>" />
        <liferay-asset:asset-tags-selector className="<%= GuestbookEntry.class.getName() %>" classPK="<%= entryId %>" />
    </aui:fieldset>
</liferay-ui:panel>

<liferay-ui:panel defaultState="closed" extended="<%= false %>" id="entryAssetLinksPanel" persistState="<%= true %>" title="related-assets">

<aui:fieldset collapsed="<%= true %>" collapsible="<%= true %>" label="related-assets">

    <liferay-asset:input-asset-links
            className="<%= GuestbookEntry.class.getName() %>"
            classPK="<%= entryId %>"
    />

</aui:fieldset>
</liferay-ui:panel>
    <aui:button-row>

        <aui:button type="submit"></aui:button>
        <aui:button type="cancel" onClick="<%= viewURL.toString() %>"></aui:button>

    </aui:button-row>
</aui:form>