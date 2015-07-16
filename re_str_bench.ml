
let re () = Re_str.regexp "\\(0*\\)http://\\([0-9a-zA-Z.-]+\\)\\(\\(/.*\\)?\\)"

let m r s = Re_str.string_match r s 0

let f r us = List.for_all (m r) us
