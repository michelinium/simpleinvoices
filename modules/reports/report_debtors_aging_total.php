<?php 
include("./include/include_main.php");

//stop the direct browsing to this file - let index.php handle which files get displayed
if (!defined("BROWSE")) {
   echo "You Cannot Access This Script Directly, Have a Nice Day.";
   exit();
}

?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>
<br>
<b>Totals by Aging periods</b>
<hr></hr>
<div id="container">

<?php
include('./config/config.php');

   // include the PHPReports classes on the PHP path! configure your path here
   include "./modules/reports/PHPReportMaker.php";

   $sSQL = "

SELECT

        (CASE WHEN datediff(now(),inv_date) <= 14 THEN (select IF ( isnull(sum(inv_it_total)) , '0', sum(inv_it_total)) from {$tb_prefix}invoices,{$tb_prefix}invoice_items where datediff(now(),inv_date) <= 14 and inv_it_invoice_id = {$tb_prefix}invoices.inv_id)
                WHEN datediff(now(),inv_date) <= 30 THEN (select  IF ( isnull(sum(inv_it_total)) , '0', sum(inv_it_total)) from {$tb_prefix}invoices,{$tb_prefix}invoice_items where datediff(now(),inv_date) <= 30 and datediff(now(),inv_date) > 14 and inv_it_invoice_id = {$tb_prefix}invoices.inv_id)
                WHEN datediff(now(),inv_date) <= 60 THEN (select  IF ( isnull(sum(inv_it_total)) , '0', sum(inv_it_total)) from {$tb_prefix}invoices,{$tb_prefix}invoice_items where datediff(now(),inv_date) <= 60 and datediff(now(),inv_date) > 30 and inv_it_invoice_id = {$tb_prefix}invoices.inv_id)
                WHEN datediff(now(),inv_date) <= 90 THEN (select  IF ( isnull(sum(inv_it_total)) , '0', sum(inv_it_total)) from {$tb_prefix}invoices,{$tb_prefix}invoice_items where datediff(now(),inv_date) <= 90 and datediff(now(),inv_date) > 60 and inv_it_invoice_id = {$tb_prefix}invoices.inv_id)
                ELSE (select  IF ( isnull(sum(inv_it_total)) , '0', sum(inv_it_total)) from {$tb_prefix}invoices,{$tb_prefix}invoice_items where datediff(now(),inv_date) > 90 and inv_it_invoice_id = {$tb_prefix}invoices.inv_id)
        END ) as Total,

        (CASE WHEN datediff(now(),inv_date) <= 14 THEN (select  IF ( isnull(sum(ac_amount)) , '0', sum(ac_amount)) from {$tb_prefix}account_payments,{$tb_prefix}invoices where datediff(now(),inv_date) <= 14 and ac_inv_id = {$tb_prefix}invoices.inv_id)
                WHEN datediff(now(),inv_date) <= 30 THEN (select IF ( isnull(sum(ac_amount)) , '0', sum(ac_amount)) from {$tb_prefix}account_payments,{$tb_prefix}invoices where datediff(now(),inv_date) > 14 and datediff(now(),inv_date) <= 30 and ac_inv_id = {$tb_prefix}invoices.inv_id )
                WHEN datediff(now(),inv_date) <= 60 THEN (select IF ( isnull(sum(ac_amount)) , '0', sum(ac_amount)) from {$tb_prefix}account_payments,{$tb_prefix}invoices where datediff(now(),inv_date) > 30 and datediff(now(),inv_date) <= 60 and ac_inv_id = {$tb_prefix}invoices.inv_id )
                WHEN datediff(now(),inv_date) <= 90 THEN (select IF ( isnull(sum(ac_amount)) , '0', sum(ac_amount)) from {$tb_prefix}account_payments,{$tb_prefix}invoices where datediff(now(),inv_date) > 60 and datediff(now(),inv_date) <= 90 and ac_inv_id = {$tb_prefix}invoices.inv_id )
                ELSE (select IF ( isnull(sum(ac_amount)) , '0', sum(ac_amount)) from {$tb_prefix}account_payments,{$tb_prefix}invoices where datediff(now(),inv_date) > 90 and ac_inv_id = {$tb_prefix}invoices.inv_id )          
	  END ) as Paid,

        (select (Total - Paid)) as Owing,

        (CASE WHEN datediff(now(),inv_date) <= 14 THEN '0-14'
                WHEN datediff(now(),inv_date) <= 30 THEN '15-30'
                WHEN datediff(now(),inv_date) <= 60 THEN '31-60'
                WHEN datediff(now(),inv_date) <= 60 THEN '61-90'
                ELSE '90+'
        END ) as Aging

FROM
        {$tb_prefix}invoices,{$tb_prefix}account_payments,{$tb_prefix}invoice_items, {$tb_prefix}biller, {$tb_prefix}customers
WHERE
        inv_it_invoice_id = {$tb_prefix}invoices.inv_id
GROUP BY
        Total;


";
   $oRpt = new PHPReportMaker();

   $oRpt->setXML("./modules/reports/xml/report_debtors_aging_total.xml");
   $oRpt->setUser("$db_user");
   $oRpt->setPassword("$db_password");
   $oRpt->setConnection("$db_host");
   $oRpt->setDatabaseInterface("mysql");
   $oRpt->setSQL($sSQL);
   $oRpt->setDatabase("$db_name");
   $oRpt->run();
?>

<hr></hr>
<a href="docs.php?t=help&p=reports_xsl" rel="gb_page_center[450, 450]"><font color="red">Did you get an "OOOOPS, THERE'S AN ERROR HERE." error?</font></a>
</div>
<div id="footer"></div>