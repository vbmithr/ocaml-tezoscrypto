(*---------------------------------------------------------------------------
   Copyright (c) 2018 Vincent Bernardoff. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
  ---------------------------------------------------------------------------*)

module Sha256 = struct
  external statebytes : unit -> int =
    "ml_crypto_hash_sha256_statebytes" [@@noalloc]

  external bytes : unit -> int =
    "ml_crypto_hash_sha256_bytes" [@@noalloc]

  external digest : Cstruct.buffer -> Cstruct.buffer -> unit =
    "ml_crypto_hash_sha256" [@@noalloc]

  external init : Cstruct.buffer -> unit =
    "ml_crypto_hash_sha256_init" [@@noalloc]

  external update : Cstruct.buffer -> Cstruct.buffer -> unit =
    "ml_crypto_hash_sha256_update" [@@noalloc]

  external final : Cstruct.buffer -> Cstruct.buffer -> unit =
    "ml_crypto_hash_sha256_final" [@@noalloc]

  let bytes = bytes ()
  let statebytes = statebytes ()

  type t = Cstruct.t

  type hash = Hash of Cstruct.t

  let init () =
    let cs = Cstruct.create_unsafe statebytes in
    init cs.buffer ;
    cs

  let update st buf =
    update st.Cstruct.buffer buf.Cstruct.buffer

  let final st =
    let cs = Cstruct.create_unsafe bytes in
    final st.Cstruct.buffer cs.buffer ;
    Hash cs

  let digest buf =
    let cs = Cstruct.create_unsafe bytes in
    digest cs.buffer buf.Cstruct.buffer ;
    Hash cs
end

module Hmac_sha512 = struct
  external bytes : unit -> int =
    "ml_crypto_auth_hmacsha512_bytes" [@@noalloc]

  external keybytes : unit -> int =
    "ml_crypto_auth_hmacsha512_keybytes" [@@noalloc]

  external auth : Cstruct.buffer -> Cstruct.buffer -> Cstruct.buffer -> unit =
    "ml_crypto_auth_hmacsha512" [@@noalloc]

  external verify : Cstruct.buffer -> Cstruct.buffer -> Cstruct.buffer -> bool =
    "ml_crypto_auth_hmacsha512_verify" [@@noalloc]

  let bytes = bytes ()
  let keybytes = keybytes ()

  type t
  type hmac = Hmac of Cstruct.t

  let auth ~key ~msg =
    if Cstruct.len key <> keybytes then
      invalid_arg (Printf.sprintf "Hmac_sha512: key must be %d bytes." bytes) ;
    let cs = Cstruct.create_unsafe bytes in
    auth cs.buffer msg.Cstruct.buffer key.Cstruct.buffer ;
    Hmac cs

  let verify ~key ~msg (Hmac auth) =
    if Cstruct.len key <> keybytes then
      invalid_arg (Printf.sprintf "Hmac_sha512: key must be %d bytes." bytes) ;
    verify auth.Cstruct.buffer msg.Cstruct.buffer key.Cstruct.buffer
end

(*---------------------------------------------------------------------------
   Copyright (c) 2018 Vincent Bernardoff

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
