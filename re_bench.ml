
let re () =
  let open Re in
  compile @@ seq [
    start ;
    rep (char '0') ;
    str "http://" ;
    rep1 ( alt [
        rg 'a' 'z' ;
        rg 'A' 'Z' ;
        rg '0' '9' ;
        char '.' ;
        char '-' ;
      ]) ;
    opt (seq [
        char '/' ;
        rep any ;
      ])
  ]

let m r s = Re.execp ~pos:0 r s
let f r us = List.for_all (m r) us
