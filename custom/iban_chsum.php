<?php
/*
 * Generate checksum for IBAN code from all we know about account
 * Return corrected IBAN string
 */
function iban_chsum( $part_a='CZ', $part_b='00', $part_c='0000', $part_d='000000', $part_e='0000000000' ) {
  $iban = (string) $part_a . $part_b . $part_c . $part_d . $part_e;
  $iban_new = (string) $part_a . iban_find_checksum( $iban ) . $part_c . $part_d . $part_e;
  return $iban_new;
}

/*
 * Original source:
 * PHP IBAN - http://code.google.com/p/php-iban - LGPLv3
 */

# Find the correct checksum for an IBAN
#  $iban  The IBAN whose checksum should be calculated
function iban_find_checksum($iban) {
 # move first 4 chars to right
 $left = substr($iban,0,2) . '00'; # but set right-most 2 (checksum) to '00'
 $right = substr($iban,4);
 # glue back together
 $tmp = $right . $left;
 # convert letters using conversion table
 $tmp = iban_checksum_string_replace($tmp);
 # get mod97-10 output
 $checksum = iban_mod97_10_checksum($tmp);
 # return 98 minus the mod97-10 output, left zero padded to two digits
 return str_pad((98-$checksum),2,'0',STR_PAD_LEFT);
}

# Set the correct checksum for an IBAN
#  $iban  IBAN whose checksum should be set
function iban_set_checksum($iban) {
 return substr($iban,0,2) . iban_find_checksum($iban) . substr($iban,4);
}

# Character substitution required for IBAN MOD97-10 checksum validation/generation
#  $s  Input string (IBAN)
function iban_checksum_string_replace($s) {
 $iban_replace_chars = range('A','Z');
 foreach (range(10,35) as $tempvalue) { $iban_replace_values[]=strval($tempvalue); }
 return str_replace($iban_replace_chars,$iban_replace_values,$s);
}

# Same as below but actually returns resulting checksum
function iban_mod97_10_checksum($numeric_representation) {
 $checksum = intval(substr($numeric_representation, 0, 1));
 for ($position = 1; $position < strlen($numeric_representation); $position++) {
  $checksum *= 10;
  $checksum += intval(substr($numeric_representation,$position,1));
  $checksum %= 97;
 }
 return $checksum;
}

# Perform MOD97-10 checksum calculation ('Germanic-level effiency' version - thanks Chris!)
function iban_mod97_10($numeric_representation) {
 global $__disable_iiban_gmp_extension;
 # prefer php5 gmp extension if available
 if(!($__disable_iiban_gmp_extension) && function_exists('gmp_intval')) { return gmp_intval(gmp_mod(gmp_init($numeric_representation, 10),'97')) === 1; }

 # new manual processing (~3x slower)
 $length = strlen($numeric_representation);
 $rest = "";
 $position = 0;
 while ($position < $length) {
        $value = 9-strlen($rest);
        $n = $rest . substr($numeric_representation,$position,$value);
        $rest = $n % 97;
        $position = $position + $value;
 }
 return ($rest === 1);
}

?>