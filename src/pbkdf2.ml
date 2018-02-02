module Pbkdf2 = struct
  let hlen = 64
  let f p s c i =
    
  let sha512 ~password ~salt ~count ~len () =
    if len > 1 lsl 30 - 1 then
      invalid_arg "Pbkdf2.sha512: derived key too long" ;
    let q = len / hlen in
    let r = len mod hlen in
    let nb_blocks = if r = 0 then q else q+1 in
    let bytes_in_last_block = len - (nb_blocks - 1) * hlen in
    ()
end
