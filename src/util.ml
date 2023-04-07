let compare_caseless s1 s2 =
  let compare_string_caseless str1 str2 =
    String.lowercase_ascii str1 = String.lowercase_ascii str2
  in
  if compare_string_caseless s1 s2 then 0 else if s1 < s2 then -1 else 1
