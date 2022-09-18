package com.liferay.docs.guestbook.search;

public interface GuestbookEntryBatchReindexer {

    public void reindex(long guestbookId, long companyId);

}