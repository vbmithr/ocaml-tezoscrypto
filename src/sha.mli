(*---------------------------------------------------------------------------
   Copyright (c) 2018 Vincent Bernardoff. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
  ---------------------------------------------------------------------------*)

module Sha256 : sig
  type t
  (** Type of a SHA256 context. *)

  type hash = Hash of Cstruct.t
  (** Type of a SHA256 digest. *)

  val bytes : int
  (** [bytes] is the digest size in bytes. *)

  val init : unit -> t
  (** [init ()] is a SHA256 context. *)

  val update : t -> Cstruct.t -> unit
  (** [update t buf] updates [t] with the data in [buf]. *)

  val final : t -> hash
  (** [final t] is the SHA256 hash of all data updated in [t] so
      far. *)

  val digest : Cstruct.t -> hash
  (** [digest buf] is the SHA256 digest of [buf]. *)
end

module Hmac_sha512 : sig
  type t
  (** Type of a HMAC-SHA512 context. *)

  type hmac = Hmac of Cstruct.t
  (** Type of a HMAC-SHA512 message authentication code. *)

  val bytes : int
  (** [bytes] is the size of an message authentication code. *)

  val keybytes : int
  (** [keybytes] is the mandatory size of keys. *)

  val auth : key:Cstruct.t -> msg:Cstruct.t -> hmac
  (** [auth ~key ~msg] is the message authentication code of [msg]
      using [key]. *)

  val verify : key:Cstruct.t -> msg:Cstruct.t -> hmac -> bool
  (** [verify ~key ~msg hmac] is [true] if [hmac] is the message
      authentication code of [msg] using [key]. *)
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
