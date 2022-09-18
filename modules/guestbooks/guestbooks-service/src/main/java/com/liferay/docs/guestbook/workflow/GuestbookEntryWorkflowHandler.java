package com.liferay.docs.guestbook.workflow;

import com.liferay.docs.guestbook.model.GuestbookEntry;
import com.liferay.docs.guestbook.service.GuestbookEntryLocalService;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.security.permission.ResourceActions;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.workflow.BaseWorkflowHandler;
import com.liferay.portal.kernel.workflow.WorkflowConstants;
import com.liferay.portal.kernel.workflow.WorkflowHandler;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import java.io.Serializable;
import java.util.Locale;
import java.util.Map;

@Component(immediate = true, service = WorkflowHandler.class)
public class GuestbookEntryWorkflowHandler extends BaseWorkflowHandler<GuestbookEntry> {

    @Override
    public String getClassName() {

        return GuestbookEntry.class.getName();

    }

    @Override
    public String getType(Locale locale) {

        return _resourceActions.getModelResource(locale, getClassName());

    }

    @Override
    public GuestbookEntry updateStatus(
            int status, Map<String, Serializable> workflowContext)
            throws PortalException {

        long userId = GetterUtil.getLong(
                (String) workflowContext.get(WorkflowConstants.CONTEXT_USER_ID));
        long resourcePrimKey = GetterUtil.getLong(
                (String) workflowContext.get(
                        WorkflowConstants.CONTEXT_ENTRY_CLASS_PK));

        ServiceContext serviceContext =
                (ServiceContext) workflowContext.get("serviceContext");

        long guestbookId =
                _guestbookEntryLocalService.getGuestbookEntry(resourcePrimKey).getGuestbookId();

        return _guestbookEntryLocalService.updateStatus(
                userId, guestbookId, resourcePrimKey, status, serviceContext);
    }

    @Reference(unbind = "-")
    protected void setGuestbookEntryLocalService(GuestbookEntryLocalService guestbookEntryLocalService) {

        _guestbookEntryLocalService = guestbookEntryLocalService;
    }

    @Reference(unbind = "-")
    protected void setResourceActions(ResourceActions resourceActions) {

        _resourceActions = resourceActions;
    }

    private GuestbookEntryLocalService _guestbookEntryLocalService;
    private ResourceActions _resourceActions;
}