<?php

//stop the direct browsing to this file - let index.php handle which files get displayed
checkLogin();	//TODO: Really needed in .tpl files? I don't think so
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="javascript" type="text/javascript" src="include/tiny_mce/tiny_mce_src.js"></script>
<script language="javascript" type="text/javascript" src="include/tiny-mce.conf.js"></script>

<link rel="stylesheet" type="text/css" href="include/jquery.datePicker.css" title="default" media="screen" />
<link rel="stylesheet" href="./src/include/css/ibox.css" type="text/css"  media="screen"/>

<script type="text/javascript" src="include/jquery.js"></script>
<script type="text/javascript" src="include/jquery.dom_creator.js"></script>
<script type="text/javascript" src="include/jquery.datePicker.js"></script>
<script type="text/javascript" src="include/jquery.datePicker.conf.js"></script>
<script type="text/javascript" src="./src/include/js/ibox.js"></script>

<!--
    <script type="text/javascript">
	$(document).ready(function() {
	 // hides the customer and biller details as soon as the DOM is ready (a little sooner that page load)
	  $('.hide').hide();
  	});
    </script>
-->

</head>
	<title>$title ::  $LANG_inv $LANG_inv_consulting></title>
<body>

<form name="frmpost" action="index.php?module=invoices&view=save" method="post" onsubmit="return frmpost_Validator(this)">

<b><$LANG_inv $LANG_inv_consulting</b>
<hr></hr>

<table align=center>
<tr>
	<td class="details_screen">
		$mb_table_biller_name
	</td>
	<td input type=text name="biller_block" size=25>
		$display_block
	</td>
</tr>
<tr>
	<td class="details_screen">
		$mc_table_customer_name
	</td>
	<td input type=text name="customer_block" size=25 >
		$display_block_customer
	</td>
</tr>
<tr>
        <td class="details_screen">$LANG_date_formatted</td>
        <td>
                        <input type="text" class="date-picker" name="select_date" id="date1" value="$today"></input>
        </td>
</tr>


<tr>
	<td class="details_screen">
		$LANG_quantity
	</td>
	<td class="details_screen">
		$LANG_description
	</td>
</tr>

	$lineitems

 
	 $show_custom_field_1
	 $show_custom_field_2
	 $show_custom_field_3
	 $show_custom_field_4

<tr>
        <td colspan=2 class="details_screen">$LANG_notes</td>
</tr>

<tr>
        <td colspan=2 ><textarea input type=text name="invoice_consulting_note" rows=5 cols=80 WRAP=nowrap></textarea></td>
</tr>

<tr>
	<td class="details_screen">$LANG_tax</td><td input type=text name="inv_it_tax" size=15>$display_block_tax</td>
</tr>

<tr>
	<td class="details_screen">$LANG_inv_pref</td><td input type=text name="inv_preferences">$display_block_preferences</td>
</tr>
<tr>
	<td align=left colspan=2> 
		<a href="./documentation/info_pages/invoice_custom_fields.html" rel="ibox&height=400">$LANG_want_more_fields<img src="./images/common/help-small.png"></img></a>

	</td>
	
</tr>
<!--Add more line items while in an itemeised invoice - Get style - has problems- wipes the current values of the existing rows - not good
<tr>
<td>
<a href="?get_num_line_items=10">Add 5 more line items<a>
</tr>
-->
</table>
<!-- </div> -->
<hr></hr>
		<input type=hidden name="max_items" value="$num">
		<input type=submit name="submit" value="$LANG_save_invoice">
		<input type=hidden name="invoice_style" value="insert_invoice_consulting">

</FORM>
<!-- ./src/include/design/footer.inc.php gets called here by controller srcipt -->