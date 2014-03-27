<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="cs-CZ">

{php}
	if( file_exists( "./library/phpqrcode/qrlib.php" ) ){
		$qrlib = TRUE;
		echo '<!-- NOTE: QRlib exist, should be included now -->';
	} else {
		echo '<!-- NOTE: QRlib NOT exist -->';
		echo '<!-- Current directory:' . getcwd() . '-->';
	}
	include_once( "./library/phpqrcode/qrlib.php" );
	include_once( "./custom/iban_chsum.php" );
{/php}

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="{$css|urlsafe}" media="all">
	<title>{$preference.pref_inv_wording|htmlsafe} {$LANG.invoice} {$invoice.index_id|htmlsafe}</title>
</head>
<body>
<br />
<div id="container">
	<div id="header">
	</div>

	<table width="100%" align="center">
		<tr>
			<td colspan="5" style="vertical-align: bottom;"><img src="{$logo|urlsafe}" border="0" hspace="0" align="left" style="max-height: 36px; margin-bottom:2px;"></td>
			<th align="right" style="vertical-align: bottom;"><span class="font1">{$preference.pref_inv_heading|htmlsafe}</span></th>
		</tr>
		<tr style="heigh: 1px; font-size:1pt;">
			<td colspan="6" class="tbl1-bottom"></td>
		</tr>
	</table>
{*********************************************************




 Summary section
**********************************************************}
	<!-- Summary - start -->

	<table class="right" width="45%" style="margin-top:2px;" >

	{* <!-- Zmena -->
		<tr>
				<td class="col1 tbl1-bottom" colspan="4" ><b>{$preference.pref_inv_wording|htmlsafe} {$LANG.summary}</b></td>
		</tr>
	*}
		<tr>
				<td class="" style="vertical-align: bottom;">{$preference.pref_inv_wording|htmlsafe} {$LANG.number_short}:</td>
				<td class="boldy" align="right" colspan="3" style="font-size: 14pt; vertical-align: bottom;">{$invoice.index_id}</td>
		</tr>
		<tr>
				<td nowrap class="tbl1-top tbl1-left tbl1-bottom">{$preference.pref_inv_wording|htmlsafe} {$LANG.date}:</td>
				<td class="tbl1-top tbl1-right tbl1-bottom" align="right" colspan="3">{$invoice.date}</td>
		</tr>
	{* -- Show the Invoice Custom Fields if valid -- *}
		{ if $invoice.custom_field2 != null}
		<tr>
				<td nowrap class="">{$customFieldLabels.invoice_cf2|htmlsafe}:</td>
				<td class="" align="right"  colspan="3">{$invoice.custom_field2|htmlsafe}</td>
		</tr>
		{/if}
		{ if $invoice.custom_field3 != null}
		<tr>
				<td nowrap class="">{$customFieldLabels.invoice_cf3|htmlsafe}:</td>
				<td class="" align="right" colspan="3">{$invoice.custom_field3|htmlsafe}</td>
		</tr>
		{/if}
		{if $invoice.custom_field1 != null}
		<tr>
				<td nowrap class="">{$customFieldLabels.invoice_cf1|htmlsafe}:</td>
				<td class="" align="right" colspan="3">{$invoice.custom_field1|htmlsafe}</td>
		</tr>
		{/if}
		{ if $invoice.custom_field4 != null}
		<tr>
				<td nowrap class="">{$customFieldLabels.invoice_cf4|htmlsafe}:</td>
				<td class="" align="right" colspan="3">{$invoice.custom_field4|htmlsafe}</td>
		</tr>
		{/if}

	{* OFF:
		<tr>
				<td class="" >{$LANG.total}: </td>
				<td class="" align="right" colspan="3">{$invoice.total|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
		</tr>
		<tr>
				<td class="">{$LANG.paid}:</td>
				<td class="" align="right" colspan="3" >{$invoice.paid|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
		</tr>
		<tr>
				<td nowrap class="">{$LANG.owing}:</td>
				<td class="" align="right" colspan="3" >{$invoice.owing|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
		</tr>
	*}
	</table>

	{*
	<div style="clear: both;"></div>
	*}
	<!-- Summary - end -->
	
	
	{* <!-- Zmena -->
	<table class="left">
	*}
	<table style="float: left;" width="45%">
		<tr>
			<td>&nbsp;<br />&nbsp;</td>
		</tr>
{*********************************************************




 Biller section (dodavatel)
**********************************************************}
    <!-- Biller section - start -->
        <tr style="vertical-align: top;">
                <td class="tbl1-bottom col1" border=1 cellpadding=2 cellspacing=1><b>{$LANG.biller}:&nbsp;</b></td>
				<td class="col1 tbl1-bottom boldy" border=1 cellpadding=2 cellspacing=1 colspan="3">{$biller.name|htmlsafe}</td>
        </tr> 

        {if $biller.street_address != null}
		<tr>
                <td class="sp-top">{$LANG.address}:</td>
			<td class="sp-top" align=left colspan="3"><b>{$biller.street_address|htmlsafe}</b></td>
    </tr>   
        {/if}
        {if $biller.street_address2 != null}
                {if $biller.street_address == null}
    <tr>
            <td class=''>{$LANG.address}:</td>
			<td class='' align=left colspan="3"><b>{$biller.street_address2|htmlsafe}</b></td>
    </tr>   
                {/if}
                {if $biller.street_address != null}
    <tr>
			<td class=''></td>
			<td class='' align=left colspan="3"><b>{$biller.street_address2|htmlsafe}</b></td>
    </tr>   
                {/if}
        {/if}
    <tr>
            <td class=''></td>
			<td class='' colspan="3"><b>{$biller.zip_code|htmlsafe}&nbsp; {$biller.city|htmlsafe}</b></td>
    </tr>

         {if $biller.country != null}
    <tr>
            <td class=''></td>
			<td class='' colspan="3"><b>{$biller.country|htmlsafe}{if $biller.state != null}, {$biller.state|htmlsafe}{/if}</b></td>
		</tr>
       	{/if}
	<!-- Zmena - small line space -->
	<tr>
			<td class='' style="font-size: 4pt;" colspan="4">&nbsp;</td>
    </tr>

	{print_if_not_null label=$LANG.phone_short field=$biller.phone class1='' class2='' colspan="3"}
	{print_if_not_null label=$LANG.fax field=$biller.fax class1='' class2='' colspan="3"}
	{print_if_not_null label=$LANG.mobile_short field=$biller.mobile_phone class1='' class2='' colspan="3"}
	{print_if_not_null label=$LANG.email field=$biller.email class1='' class2='' colspan="3"}
	
	{print_if_not_null label=$customFieldLabels.biller_cf1 field=$biller.custom_field1 class1='' class2='' colspan="3"}
	{print_if_not_null label=$customFieldLabels.biller_cf2 field=$biller.custom_field2 class1='' class2='' colspan="3"}
	{print_if_not_null label=$customFieldLabels.biller_cf3 field=$biller.custom_field3 class1='tbl1-top tbl1-left' class2='tbl1-top tbl1-right boldy' colspan="3"}
	{print_if_not_null label=$customFieldLabels.biller_cf4 field=$biller.custom_field4 class1='tbl1-bottom tbl1-left' class2='tbl1-bottom tbl1-right' colspan="3"}

	<!-- Biller section - end -->
	</table>

	<table class="right" width="45%">
		<tr>
			<td>&nbsp;<br />&nbsp;</td>
		</tr>
{*********************************************************




 Customer section (odběratel)
**********************************************************}
	<!-- Customer section - start -->
	<tr style="vertical-align: top;">
			<td class="tbl1-bottom col1"><b>{$LANG.customer}:&nbsp;</b></td>
			<td class="tbl1-bottom col1 boldy" colspan="3">{$customer.name|htmlsafe}</td>
	</tr>

        {if $customer.attention != null }
    <tr>
            <td class="sp-top">{$LANG.attention_short}:</td>
			<td align=left class="sp-top" colspan="3" ><b>{$customer.attention|htmlsafe}</b></td>
                </tr>
       {/if}
        {if $customer.street_address != null }
    <tr >
            <td class="sp-top">{$LANG.address}:</td>
			<td class="sp-top" align=left colspan="3"><b>{$customer.street_address|htmlsafe}</b></td>
    </tr>   
        {/if}
        {if $customer.street_address2 != null}
                {if $customer.street_address == null}
    <tr>
            <td class=''>{$LANG.address}:</td>
			<td class='' align=left colspan="3"><b>{$customer.street_address2|htmlsafe}</b></td>
    </tr>   
                {/if}
                {if $customer.street_address != null}
    <tr>
			<td class=''></td>
			<td class='' align=left colspan="3"><b>{$customer.street_address2|htmlsafe}</b></td>
    </tr>   
                {/if}
        {/if}
    <tr>
            <td class=''></td>
			<td class='' colspan="3"><b>{$customer.zip_code|htmlsafe}&nbsp; {$customer.city|htmlsafe}</b></td>
    </tr>

         {if $customer.country != null}
    <tr>
            <td class=''></td>
			<td class='' colspan="3"><b>{$customer.country|htmlsafe}{if $customer.state != null}, {$customer.state|htmlsafe}{/if}</b></td>
    </tr>
        {/if}
	<!-- Zmena - small line space -->
	<tr>
			<td class='' style="font-size: 4pt;" colspan="4">&nbsp;</td>
    </tr>
	{print_if_not_null label=$LANG.phone_short field=$customer.phone class1='' class2='t' colspan="3"}
	{print_if_not_null label=$LANG.fax field=$customer.fax class1='' class2='' colspan="3"}
	{print_if_not_null label=$LANG.mobile_short field=$customer.mobile_phone class1='' class2='' colspan="3"}
	{print_if_not_null label=$LANG.email field=$customer.email class1='' class2='' colspan="3"}
	
	{print_if_not_null label=$customFieldLabels.customer_cf1 field=$customer.custom_field1 class1='' class2='' colspan="3"}
	{print_if_not_null label=$customFieldLabels.customer_cf2 field=$customer.custom_field2 class1='' class2='' colspan="3"}
	{print_if_not_null label=$customFieldLabels.customer_cf3 field=$customer.custom_field3 class1='' class2='' colspan="3"}
	{print_if_not_null label=$customFieldLabels.customer_cf4 field=$customer.custom_field4 class1='' class2='' colspan="3"}
	</table>
	<!-- Customer section - end -->

	<div style="clear: both;"></div>
{*********************************************************




 Details section
**********************************************************}
	<table class="left" width="100%">
		<tr>
			<td colspan="6">&nbsp;<br />&nbsp;</td>
		</tr>
		{if $invoice.type_id == 2 }
			<tr>
				<td class="tbl1-bottom col1" width="10%"><b>{$LANG.quantity_short}&nbsp;</b></td>
				<td class="tbl1-bottom col1" colspan="3"><b>{$LANG.item}</b></td>
				<td class="tbl1-bottom col1" width="20%" align="right"><b>{$LANG.unit_cost}</b></td>
				<td class="tbl1-bottom col1" width="16%" align="right"><b>{$LANG.price}</b></td>
			</tr>
			{foreach from=$invoiceItems item=invoiceItem}
				<tr class="" >
					<td class="sp-top">{$invoiceItem.quantity|siLocal_number_trim}</td>
					<td class="sp-top" colspan="3">{$invoiceItem.product.description|htmlsafe}</td>
					<td class="sp-top" align="right">{$invoiceItem.unit_price|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
					<td class="sp-top" align="right">{$invoiceItem.gross_total|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
				</tr>
				{if $invoiceItem.description != null}
				<tr class="">
					<td class=""></td>
					<td class="" colspan="5">{$LANG.description}: {$invoiceItem.description|htmlsafe}</td>
				</tr>
				{/if}
	            <tr class="tbl1-bottom">
	                <td class=""></td>
					<td class="" colspan="5">
						<table class="ms-bottom" width="100%">
							<tr>
							{inv_itemised_cf label=$customFieldLabels.product_cf1 field=$invoiceItem.product.custom_field1}
							{do_tr number=1 class="blank-class"}
							{inv_itemised_cf label=$customFieldLabels.product_cf2 field=$invoiceItem.product.custom_field2}
							{do_tr number=2 class="blank-class"}
							{inv_itemised_cf label=$customFieldLabels.product_cf3 field=$invoiceItem.product.custom_field3}
							{do_tr number=3 class="blank-class"}
							{inv_itemised_cf label=$customFieldLabels.product_cf4 field=$invoiceItem.product.custom_field4}
							{do_tr number=4 class="blank-class"}
							</tr>
						</table>
	                </td>
	            </tr>
         	{/foreach}
	{/if}

	{if $invoice.type_id == 3 }
			<tr class="tbl1-bottom col1">
				<td class="tbl1-bottom" width="10%"><b>{$LANG.quantity_short}</b></td>
				<td class="tbl1-bottom" colspan="3"><b>{$LANG.item}</b></td>
				<td class="tbl1-bottom" width="20%" align="right"><b>{$LANG.unit_cost}</b></td>
				<td class="tbl1-bottom" width="16%" align="right"><b>{$LANG.price}</b></td>
			</tr>
		
			{foreach from=$invoiceItems item=invoiceItem}
	
			<tr class=" ">
				<td class="sp-top" >{$invoiceItem.quantity|siLocal_number}</td>
				<td class="sp-top">{$invoiceItem.product.description|htmlsafe}</td>
				<td class="sp-top" colspan="4"></td>
			</tr>
			
						
            <tr>       
                <td class=""></td>
				<td class="" colspan="5">
                    <table class="ms-bottom" width="100%">
                        <tr>

					{inv_itemised_cf label=$customFieldLabels.product_cf1 field=$invoiceItem.product.custom_field1}
					{do_tr number=1 class="blank-class"}
					{inv_itemised_cf label=$customFieldLabels.product_cf2 field=$invoiceItem.product.custom_field2}
					{do_tr number=2 class="blank-class"}
					{inv_itemised_cf label=$customFieldLabels.product_cf3 field=$invoiceItem.product.custom_field3}
					{do_tr number=3 class="blank-class"}
					{inv_itemised_cf label=$customFieldLabels.product_cf4 field=$invoiceItem.product.custom_field4}
					{do_tr number=4 class="blank-class"}

                        </tr>
                    </table>
                </td>
            </tr>
	
			<tr class="">
				<td class=""></td>
				<td class="" colspan="5"><i>{$LANG.description}: </i>{$invoiceItem.description|htmlsafe}</td>
			</tr>
			<tr class="">
				<td class="" ></td>
				<td class=""></td>
				<td class=""></td>
				<td class=""></td>
				<td align="right" class="">{$invoiceItem.unit_price|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
				<td align="right" class="">{$invoiceItem.total|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
			</tr>
			{/foreach}
	{/if}
	
	{if $invoice.type_id == 1 }
	{*
	    <table class="left" width="100%">
	*}
        <tr class="col1">
            <td class="col1 tbl1-bottom" colspan="6"><b>{$LANG.description}</b></td>
        </tr>
	{foreach from=$invoiceItems item=invoiceItem}
	<tr class="">
            <td class="space" colspan="6">{$invoiceItem.description|outhtml}</td>
        </tr>
	{/foreach}
	{/if}

{if ($invoice.type_id == 2 && $invoice.note != "") || ($invoice.type_id == 3 && $invoice.note != "" )  }

		<tr>
			<td class="" colspan="6"><br /></td>
		</tr> {* <!-- VYPNUTO -->
		<tr>
			<td class="" colspan="6" align="left"><b>{$LANG.notes}:</b></td>
		</tr>  *}
		<tr>
			<td class="" colspan="6">{$invoice.note|outhtml}</td>
		</tr>

{/if}

	<tr class="">
		<td class="" colspan="6" ><br /></td>
	</tr>

    {* tax section - start *}
	{if $invoice_number_of_taxes > 0}
	<tr>
        <td width="10%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
		<td width="20%" colspan="1" align="right">{$LANG.sub_total}</td>
		<td width="16%" colspan="1" align="right">{if $invoice_number_of_taxes > 1}<u>{/if}{$invoice.gross|siLocal_number}{$preference.pref_currency_sign|htmlsafe}{if $invoice_number_of_taxes > 1}</u>{/if}</td>
    </tr>
    {/if}
	{if $invoice_number_of_taxes > 1 }
	        <tr>
        	        <td colspan="6"><br /></td>
	        </tr>
    {/if}
    {section name=line start=0 loop=$invoice.tax_grouped step=1}
    	{if ($invoice.tax_grouped[line].tax_amount != "0") }
    	
    	<tr>
	        <td colspan="4">&nbsp;</td>
			<td colspan="1" align="right" width="20%">{$invoice.tax_grouped[line].tax_name|htmlsafe}</td>
			<td colspan="1" align="right" width="16%">{$invoice.tax_grouped[line].tax_amount|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
	    </tr>
	    {/if}
	    
	{/section}
	{if $invoice_number_of_taxes > 1}
	<tr>
        <td colspan="4">&nbsp;</td>
		<td colspan="1" align="right" width="20%">{$LANG.tax_total}</td>
		<td colspan="1" align="right" width="16%"><u>{$invoice.total_tax|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</u></td>
    </tr>
    {/if}
	{if $invoice_number_of_taxes > 1}
	<tr>
		<td colspan="6"><br /></td>
	</tr>
    {/if}
    <tr>
        <td colspan="4">&nbsp;</td>
		<td colspan="1" align="right" width="20%" style="vertical-align:baseline;"><b>{$preference.pref_inv_wording|htmlsafe} {$LANG.amount}</b></td>
		<td colspan="1" align="right" width="16%" style="vertical-align:baseline;"><span class="double_underline">{$invoice.total|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</span></td>
    </tr>
    {* tax section - end *}
{* OFF:
		<tr>
			<td class="" colspan="4">&nbsp;</td>
			<td align="right" colspan="1">{$LANG.sub_total}</td>
			<td align="right" class="">{$invoice.gross|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
		</tr>
	
    {section name=line start=0 loop=$invoice.tax_grouped step=1}
		{if ($invoice.tax_grouped[line].tax_amount != "0") }  
		<tr class=''>
	        <td colspan="4">&nbsp;</td>
			<td colspan="1" align="right">{$invoice.tax_grouped[line].tax_name|htmlsafe}</td>
			<td colspan="1" align="right">{$invoice.tax_grouped[line].tax_amount|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</td>
	    </tr>
	    {/if}
	{/section}
	
	<tr class="">
	<td colspan="4">&nbsp;</td>
		<td colspan="1" align="right">{$LANG.tax_total}</td>
		<td colspan="1" align="right"><u>{$invoice.total_tax|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</u></td>
    </tr>
	<tr class="">
		<td class="" colspan="6" ><br /></td>
	</tr>
	<tr class="">
		<td class="" colspan="4">&nbsp;</td>
		<td class="" align="right" colspan="1"><b>{$preference.pref_inv_wording|htmlsafe} {$LANG.amount}</b></td>
		<td class="" align="right"><span class="double_underline">{$invoice.total|siLocal_number}{$preference.pref_currency_sign|htmlsafe}</span></td>
	</tr>
:OFF *}
	<tr>
		<td colspan="6"><br /><br /></td>
	</tr>
</table>

{*********************************************************




 New QR code payment section
**********************************************************}
{php}
	$biller_account_full = preg_replace( '/[^\d-\/]/', '', $this->_tpl_vars['biller']['custom_field3'] );
		// Allow only numbers, minus and slash
	$biller_account = substr( $biller_account_full, 0, -5 );
		// All except last four digits
	$biller_bank = substr( $biller_account_full, -4);
		// Last four digits
	$total_price = number_format($this->_tpl_vars['invoiceItem']['gross_total'],2,'.','');

	if( class_exists( 'QRcode' ) && function_exists( 'iban_chsum' )){
		$qr_local = TRUE;
		
		$qr_php_path = '.';
		$qr_url_path = getURL();
		$tmp = '/tmp/cache/';

		/* Convert account number to IBAN: */
		$iban_a = 'CZ';
			// country code (TODO: currently fixed, should be get from elsewhere)
		$iban_b = '00';
			// checksum
		$iban_c = ( empty( $biller_bank ) ) ? '0000' : $biller_bank;
			// bank code
		$iban_d = '000000';
			// number before dash
		$dash = strpos( $biller_account, '-' );
		if ( $dash === FALSE ) {
			$iban_e = ( empty( $biller_account ) ) ? '0000000000' : substr( sprintf( '%010s', $biller_account ), -10 );
			// after dash
		} else {
			$iban_d = substr( sprintf( '%06s', substr( $biller_account, 0, $dash ) ), -6 );
			$iban_e = substr( sprintf( '%010s', substr( $biller_account, $dash + 1 ) ), -10 );
		}
		/* Call function outside to get IBAN with proper checksum */
		$iban = iban_chsum( $iban_a, $iban_b, $iban_c, $iban_d, $iban_e );
		
		$qr_string  = 'SPD*1.0';
		$qr_string .= '*ACC:' . $iban;
		$qr_string .= '*AM:' . $total_price;
		$qr_string .= '*CC:CZK';
			// currency (TODO: currently fixed, should be get from elsewhere)
		$qr_string .= '*X-VS:' . $this->_tpl_vars['invoice']['index_id'];
		$qr_string .= '*MSG:' . mb_strtoupper( $this->_tpl_vars['invoice']['custom_field1'], 'UTF-8' );

		$qr_name = 'qr_' . $this->_tpl_vars['invoice']['index_id'] . '_' . md5( $qr_string ) . '.png';
		$qr_php_name = $qr_php_path . $tmp . $qr_name;
		$qr_url_name = $qr_url_path . $tmp . $qr_name;

		if ( !file_exists( $qr_php_name ) ) {
			QRcode::png( $qr_string, $qr_php_name, 'L', 7, 2 );
		}
	}
{/php}

<div style="float:left; max-width:24%;" width="24%">
	{php}
	if ( $qr_local ) :
		echo '<div class="qr_border" style="position:relative;border:1px solid #000;padding:10px;margin-right:10px;">';
		echo '<img style="width:140px;max-width:100%;" alt="QR platba" src="';
		echo $qr_url_name;
		echo '"/>';
		echo '<span class="qr_tag font3" style="position:absolute;top:100%;left:0;margin-top:4px;">QR Platba</span>';
		echo '</div>';
	else :
		echo '<img style="max-width:100%;margin-top:-16px;margin-left:-13px;" alt="QR platba" src="http://api.paylibo.com/paylibo/generator/czech/image?accountNumber=';
		echo $biller_account;
		echo '&bankCode=';
		echo $biller_bank;
		echo '&amount=';
		echo $total_price;
		echo '&currency=CZK&vs=';
		echo $this->_tpl_vars['invoice']['index_id'];
		echo '&message=';
		echo htmlsafe( $this->_tpl_vars['invoice']['custom_field1'] );
		echo '&size=400"/>';
	endif;
	{/php}
</div>

{*********************************************************




 Footer section
**********************************************************}
<!-- invoice details section - start -->
<table class="right" width="76%">
	<tr>
		<td class="tbl1-bottom col1" colspan="5"><b>{$preference.pref_inv_detail_heading|htmlsafe}</b></td>
	</tr>
	<tr>
		<td class="font2 sp-top" colspan="5">{$preference.pref_inv_detail_line|outhtml}</td>
	</tr>
	<tr>
		<td class="font2" colspan="5">{$preference.pref_inv_payment_method|htmlsafe}</td>
	</tr>
	<tr>
		<td class="font2" colspan="5">{$preference.pref_inv_payment_line1_name|htmlsafe} {$preference.pref_inv_payment_line1_value|htmlsafe}</td>
	</tr>
	<tr>
		<td class="font2" colspan="5">{$preference.pref_inv_payment_line2_name|htmlsafe} {$preference.pref_inv_payment_line2_value|htmlsafe}</td>
	</tr>
	<tr>
		<td><br /></td>
	</tr>
	<tr>
		<td colspan="5"><div class="font3" align="left">{$biller.footer|outhtml}</div></td>
	</tr>
	<tr>
		<td>
			{online_payment_link 
				type=$preference.include_online_payment business=$biller.paypal_business_name 
				item_name=$invoice.index_name invoice=$invoice.id 
				amount=$invoice.total currency_code=$preference.currency_code
				link_wording=$LANG.paypal_link
				notify_url=$biller.paypal_notify_url return_url=$biller.paypal_return_url
				domain_id = $invoice.domain_id include_image=true
			}
		</td>
	</tr>

</table>
<!-- invoice details section - end -->


<div id="footer"></div>

</div>

</body>
</html>