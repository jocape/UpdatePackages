{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is:  vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
* Contributor(s): YetiForce.com
********************************************************************************/
-->*}
{strip}
	{if !empty($PARENT_COMMENTS)}
		<ul class="liStyleNone">
			{if $CURRENT_COMMENT}
				{assign var=CHILDS_ROOT_PARENT_MODEL value=$CURRENT_COMMENT}
				{assign var=CURRENT_COMMENT_PARENT_MODEL value=$CURRENT_COMMENT->getParentCommentModel()}
				{while $CURRENT_COMMENT_PARENT_MODEL neq false}
					{assign var=TEMP_COMMENT value=$CURRENT_COMMENT_PARENT_MODEL}
					{assign var=CURRENT_COMMENT_PARENT_MODEL value=$CURRENT_COMMENT_PARENT_MODEL->getParentCommentModel()}
					{if $CURRENT_COMMENT_PARENT_MODEL eq false}
						{assign var=CHILDS_ROOT_PARENT_MODEL value=$TEMP_COMMENT}
					{/if}	
				{/while}
			{/if}
			{if is_array($PARENT_COMMENTS)}
				{foreach key=Index item=COMMENT from=$PARENT_COMMENTS}
					{assign var=PARENT_COMMENT_ID value=$COMMENT->getId()}
					<li class="commentDetails">
						{include file=\App\Layout::getTemplatePath('Comment.tpl') COMMENT=$COMMENT COMMENT_MODULE_MODEL=$COMMENTS_MODULE_MODEL}
						{if $CHILDS_ROOT_PARENT_MODEL}
							{if $CHILDS_ROOT_PARENT_MODEL->getId() eq $PARENT_COMMENT_ID}		
								{assign var=CHILD_COMMENTS_MODEL value=$CHILDS_ROOT_PARENT_MODEL->getChildComments()}
								{include file=\App\Layout::getTemplatePath('CommentsListIteration.tpl') CHILD_COMMENTS_MODEL=$CHILD_COMMENTS_MODEL}
							{/if}
						{/if}
					</li>	
				{/foreach}
			{else}
				{include file=\App\Layout::getTemplatePath('Comment.tpl') COMMENT=$PARENT_COMMENTS}
			{/if}
		</ul>
	{/if}
	<div class="summaryWidgetContainer noCommentsMsgContainer {if !empty($PARENT_COMMENTS)}hide{/if}">
		<p class="textAlignCenter"> {\App\Language::translate('LBL_NO_COMMENTS',$MODULE_NAME)}</p>
	</div>
{/strip}