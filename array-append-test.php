<?php

error_reporting(E_ALL & ~E_NOTICE);

$longopts = array(
	"append-type:",
	"num-elements:",
	"element-size:",
);

$options = getopt("", $longopts);

$append_type = $options['append-type'];

if (!isset($append_type)){
	echo "must define append type\n";
	exit;
}

$num_elements = $options['num-elements'] ?: 1000;
$element_size = $options['element-size'] ?: 100;

$test_arr1 = generate_test_data($num_elements, $element_size);
$test_arr2 = generate_test_data($num_elements, $element_size);

$start_time = microtime(true);
$result = call_user_func("test_{$append_type}", $test_arr1, $test_arr2);
$end_time = microtime(true);

$run_time_ms = ($end_time - $start_time) *1000;
echo "{$append_type},{$num_elements},{$element_size}," . sprintf("%.3f", $run_time_ms) . "\n";

function generate_test_data($count, $element_size){
	$test_data = array();
	$is_secure = false;
	while($count > 0){
		$element_string = bin2hex(openssl_random_pseudo_bytes(ceil($element_size / 2)));
		if ($element_size % 2 != 0) $element_string = substr($element_string, 1);

		$test_data[] = $element_string;
		$count--;
	}

	return $test_data;
}

function test_builtin_append($arr1, $arr2){
	foreach ($arr2 as $arr2_val){
		$arr1[] = $arr2_val;
	}

	return $arr1;
}

function test_array_merge($arr1, $arr2){
	return array_merge($arr1, $arr2);
}

function test_array_prepend($arr1, $arr2){
	for ($i = count($arr1) - 1; $i >= 0; $i--){
		array_unshift($arr2, $arr1[$i]);
	}

	return $arr1;
}
