include "./true.yar"

import "pe"
import "math"

rule BASIC_BOOL {
  condition:
    true
}

rule BASIC_BOOL2 {
  condition:
    false
}

rule HEX_STRING {
  strings:
    $h1 = {01 23 45 67 89 ab}
    $h2 = {cd ef 01 23 45 67}
  condition:
    any of ($h*)
}

rule REGEX1 {
  strings:
    $r1 = /first regex/
  condition:
    $r1
}

rule REGEX2 {
  strings:
    $r1 = /regex with mod i/i
    $r2 = /regex with mod s/s
  condition:
    $r1 or $r2
}

rule STRING1 {
  strings:
    $s1 = "ABCDEFG"
  condition:
    $s1
}

rule STRING2 {
  strings:
    $s1 = "ABCDEFG"
    $s2 = "HIJKLMN"
  condition:
    $s1 or $s2
}

rule TAG : tag1 {
  condition:
    true
}

rule TAG_STRING : tag2 {
  strings:
    $s1 = "ABCDEFG"
  condition:
    $s1
}

rule TAGS : tag1 tag2 tag3 {
  condition:
    true
}

global rule GLOBAL {
  condition:
    true
}

private rule PRIVATE {
  condition:
    true
}

rule META {
  meta:
    meta_str = "string metadata"
    meta_int = 42
    meta_neg = -42
    meta_true = true
    meta_false = false
  condition:
    true
}

rule XOR {
  strings:
    $xor1 = "xor!" xor
    $xor2 = "xor?" nocase xor
    $xor3 = /xor_/ xor
    $no_xor1 = "no xor :(" wide
    $no_xor2 = "no xor >:(" ascii nocase
  condition:
    any of them
}

rule OCCURRENCES {
  strings:
    $a = "str1"
    $b = "str2"
    $c = "str3"
  condition:
    #a == 20 and #b < 5 and #c >= 30
}

rule FOR_IN {
  strings:
    $a = "str1"
    $b = "str2"
    $c = "str3"
  condition:
    for any i in (5, 10, 15) : (@a[i] % 6 == @c[i * 2])
}

rule FOR_OF {
  meta:
    description = "for..of rule"
  strings:
    $a = "str"
    $b = /regex/
    $c = {00 11 22}
  condition:
    for all of ($a, $b, $c) : ($ at entrypoint)
}

rule INTEGER_FUNCTION {
  condition:
    uint8(500) == 3470 and uint16(uint32(100)) == 275
}

rule MATCHES {
  condition:
    some_string matches /[a-z0-9]*/i
}

rule CONTAINS {
  condition:
    some_string contains "this string"
}

rule NOT {
  condition:
    not that_var and this_var < 500
}

rule PRECEDENCE_NO_PARENS {
  condition:
    "foo" | "bar" >> 5
}

rule PRECEDENCE_PARENS {
  condition:
    ("foo" | "bar") >> 5
}

rule RANGE {
  strings:
    $a = "str1"
    $b = "str2"
  condition:
    $a in (0..100) and $b in (100..filesize)
}

rule SET_OF_STRINGS {
  strings:
    $foo1 = "foo1"
    $foo2 = "foo2"
    $foo3 = "foo3"
    $foo4 = "foo4"
  condition:
    2 of ($foo1, $foo2, $foo4*)
}

rule AND_OR_PRECEDENCE_NO_PARENS {
  strings:
    $foo1 = "foo1"
    $foo2 = /foo2/
    $foo3 = {AA BB CC}
  condition:
    $foo1 or $foo2 or $foo3 and $foo4
}

rule AND_OR_PRECEDENCE_PARENS {
  strings:
    $foo1 = "foo1"
    $foo2 = /foo2/
    $foo3 = {AA BB CC}
  condition:
    ($foo1 or $foo2 or $foo3) and $foo4
}

rule STRING_LENGTH {
  strings:
    $foo1 = /foo(1)+/
  condition:
    for all i in (5, 10, 15) : (!foo1[i] >= 20)
}

rule MODULE {
  condition:
    foo.bar(10, 20, 30) != "text"
}

