open Tezoscrypto

let msg = "Voulez-vous coucher avec moi, ce soir ?" |> Cstruct.of_string
let msglen = Cstruct.len msg

let sha256 () =
  let open Sha.Sha256 in
  let resp = `Hex "bd4860cc3f39995c47f94205a86c9e22e2fc8ab91c88c5293b704d454991f757" in
  let (Hash digest) = Sha.Sha256.digest msg in
  assert (resp = (Hex.of_cstruct digest))

let hash = [
  "sha256", `Quick, sha256 ;
]

let () =
  Alcotest.run "tezoscrypto" [
    "hash", hash ;
  ]
