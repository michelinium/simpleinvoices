{strip}

{* 	######################################################################################################################################
	You can use these "hooks" to add your custom code in some strategic places, without having to override any template file.
	HowTo: Just replace the content of each capture tag with your own HTML parts, ie: {capture nane=xxxx}<!-- Your html code here -->{/capture}
	Tip: Search the following  <!-- HOOK_*** -->  comments in the HTML source code or any page to discover where these hooks are placed.
	######################################################################################################################################  *}


{* Inside <HEAD></HEAD> --------------------------------------------------------------- *}

{capture name=hook_head_start}
	<!-- HOOK_head_start -->
{/capture}

{capture name=hook_head_end}
	<!-- HOOK_head_end -->

	{literal}
	<meta name="viewport" content="width=480px, height=device-height, initial-scale=0.7, user-scalable=yes">
	<style type="text/css">
        @import url("./custom/login-new.css");
	</style>
	<script>
	function compareDate(str1){
		// str1 format should be yyyy-mm-dd. Separator can be anything e.g. / or -. It wont effect
		var yr1   = parseInt(str1.substring(0,4));
		var mon1  = parseInt(str1.substring(5,7));
		var dt1   = parseInt(str1.substring(8,10));
		var date1 = new Date(yr1, mon1-1, dt1);
		return date1;
	};

	function customDate(){
		var days = 14;
		var date_val = $('input[name="date"]').val();
		var date_plus = compareDate(date_val);
		date_plus = new Date(date_plus);
		date_plus = date_plus.setDate(date_plus.getDate()+days);
		var date_us = new Date(date_plus);
		var date1 = date_us.getDate();
		var date2 = date_us.getMonth()+1;
		var date3 = date_us.getFullYear();
		var date_string = date1 + '.' + date2 + '.' + date3;
		$('input[name="customField3"]').val(date_string);
	};
	$(document).ready(function(){
		$('input[name="date"], input[name="customField3"]').focus(function() {
			customDate();
		});
	});
	</script>
	{/literal}

{/capture}


{* Inside <BODY></BODY> --------------------------------------------------------------- *}

{capture name=hook_body_start}
	<!-- HOOK_body_start -->

	<div id="wall">
	</div><!-- #wall -->

{/capture}

{capture name=hook_body_end}
	<!-- HOOK_body_end -->
{/capture}


{* Inside Top Menu DIV ---------------------------------------------------------------- *}

{capture name=hook_topmenu_start}
	<!-- HOOK_topmenu_start -->
{/capture}

{capture name=hook_topmenu_end}
	<!-- HOOK_topmenu_end -->
{/capture}

{* Inside Tabs Menu DIV --------------------------------------------------------------- *}
{capture name=hook_tabmenu_start}
	<!-- HOOK_tabmenu_start -->
{/capture}

{capture name=hook_tabmenu_end}
	<!-- HOOK_tabmenu_end -->
{/capture}


{* Inside Main Tabs Menu UL  ---------------------------------------------------------- *}

{capture name=hook_tabmenu_main_start}
	<!-- HOOK_tabmenu_main_start -->
{/capture}

{capture name=hook_tabmenu_main_end}
	<!-- HOOK_tabmenu_main_end -->
{/capture}


{/strip}