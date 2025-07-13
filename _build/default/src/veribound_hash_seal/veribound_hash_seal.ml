type __ = Obj.t
let __ = let rec f _ = Obj.repr f in Obj.repr f

type ('a, 'b) sum =
| Inl of 'a
| Inr of 'b

(** val snd : ('a1 * 'a2) -> 'a2 **)

let snd = function
| (_, y) -> y

type comparison =
| Eq
| Lt
| Gt

(** val compOpp : comparison -> comparison **)

let compOpp = function
| Eq -> Eq
| Lt -> Gt
| Gt -> Lt

type 'a sig0 = 'a
  (* singleton inductive, whose constructor was exist *)



(** val pred : int -> int **)

let pred = fun n -> Stdlib.max 0 (n-1)

module Coq__1 = struct
 (** val add : int -> int -> int **)

 let add = (+)
end
include Coq__1

(** val mul : int -> int -> int **)

let mul = ( * )

type positive =
| XI of positive
| XO of positive
| XH

type z =
| Z0
| Zpos of positive
| Zneg of positive

module Nat =
 struct
  (** val add : int -> int -> int **)

  let rec add n m =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> m)
      (fun p -> Stdlib.Int.succ (add p m))
      n

  (** val mul : int -> int -> int **)

  let rec mul n m =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> 0)
      (fun p -> add m (mul p m))
      n

  (** val pow : int -> int -> int **)

  let rec pow n m =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> Stdlib.Int.succ 0)
      (fun m0 -> mul n (pow n m0))
      m
 end

module Pos =
 struct
  type mask =
  | IsNul
  | IsPos of positive
  | IsNeg
 end

module Coq_Pos =
 struct
  (** val succ : positive -> positive **)

  let rec succ = function
  | XI p -> XO (succ p)
  | XO p -> XI p
  | XH -> XO XH

  (** val add : positive -> positive -> positive **)

  let rec add x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> XO (add_carry p q0)
       | XO q0 -> XI (add p q0)
       | XH -> XO (succ p))
    | XO p ->
      (match y with
       | XI q0 -> XI (add p q0)
       | XO q0 -> XO (add p q0)
       | XH -> XI p)
    | XH -> (match y with
             | XI q0 -> XO (succ q0)
             | XO q0 -> XI q0
             | XH -> XO XH)

  (** val add_carry : positive -> positive -> positive **)

  and add_carry x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> XI (add_carry p q0)
       | XO q0 -> XO (add_carry p q0)
       | XH -> XI (succ p))
    | XO p ->
      (match y with
       | XI q0 -> XO (add_carry p q0)
       | XO q0 -> XI (add p q0)
       | XH -> XO (succ p))
    | XH ->
      (match y with
       | XI q0 -> XI (succ q0)
       | XO q0 -> XO (succ q0)
       | XH -> XI XH)

  (** val pred_double : positive -> positive **)

  let rec pred_double = function
  | XI p -> XI (XO p)
  | XO p -> XI (pred_double p)
  | XH -> XH

  type mask = Pos.mask =
  | IsNul
  | IsPos of positive
  | IsNeg

  (** val succ_double_mask : mask -> mask **)

  let succ_double_mask = function
  | IsNul -> IsPos XH
  | IsPos p -> IsPos (XI p)
  | IsNeg -> IsNeg

  (** val double_mask : mask -> mask **)

  let double_mask = function
  | IsPos p -> IsPos (XO p)
  | x0 -> x0

  (** val double_pred_mask : positive -> mask **)

  let double_pred_mask = function
  | XI p -> IsPos (XO (XO p))
  | XO p -> IsPos (XO (pred_double p))
  | XH -> IsNul

  (** val sub_mask : positive -> positive -> mask **)

  let rec sub_mask x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> double_mask (sub_mask p q0)
       | XO q0 -> succ_double_mask (sub_mask p q0)
       | XH -> IsPos (XO p))
    | XO p ->
      (match y with
       | XI q0 -> succ_double_mask (sub_mask_carry p q0)
       | XO q0 -> double_mask (sub_mask p q0)
       | XH -> IsPos (pred_double p))
    | XH -> (match y with
             | XH -> IsNul
             | _ -> IsNeg)

  (** val sub_mask_carry : positive -> positive -> mask **)

  and sub_mask_carry x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> succ_double_mask (sub_mask_carry p q0)
       | XO q0 -> double_mask (sub_mask p q0)
       | XH -> IsPos (pred_double p))
    | XO p ->
      (match y with
       | XI q0 -> double_mask (sub_mask_carry p q0)
       | XO q0 -> succ_double_mask (sub_mask_carry p q0)
       | XH -> double_pred_mask p)
    | XH -> IsNeg

  (** val sub : positive -> positive -> positive **)

  let sub x y =
    match sub_mask x y with
    | IsPos z0 -> z0
    | _ -> XH

  (** val mul : positive -> positive -> positive **)

  let rec mul x y =
    match x with
    | XI p -> add y (XO (mul p y))
    | XO p -> XO (mul p y)
    | XH -> y

  (** val iter : ('a1 -> 'a1) -> 'a1 -> positive -> 'a1 **)

  let rec iter f x = function
  | XI n' -> f (iter f (iter f x n') n')
  | XO n' -> iter f (iter f x n') n'
  | XH -> f x

  (** val size_nat : positive -> int **)

  let rec size_nat = function
  | XI p0 -> Stdlib.Int.succ (size_nat p0)
  | XO p0 -> Stdlib.Int.succ (size_nat p0)
  | XH -> Stdlib.Int.succ 0

  (** val compare_cont : comparison -> positive -> positive -> comparison **)

  let rec compare_cont r x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> compare_cont r p q0
       | XO q0 -> compare_cont Gt p q0
       | XH -> Gt)
    | XO p ->
      (match y with
       | XI q0 -> compare_cont Lt p q0
       | XO q0 -> compare_cont r p q0
       | XH -> Gt)
    | XH -> (match y with
             | XH -> r
             | _ -> Lt)

  (** val compare : positive -> positive -> comparison **)

  let compare =
    compare_cont Eq

  (** val ggcdn :
      int -> positive -> positive -> positive * (positive * positive) **)

  let rec ggcdn n a b =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> (XH, (a, b)))
      (fun n0 ->
      match a with
      | XI a' ->
        (match b with
         | XI b' ->
           (match compare a' b' with
            | Eq -> (a, (XH, XH))
            | Lt ->
              let (g, p) = ggcdn n0 (sub b' a') a in
              let (ba, aa) = p in (g, (aa, (add aa (XO ba))))
            | Gt ->
              let (g, p) = ggcdn n0 (sub a' b') b in
              let (ab, bb) = p in (g, ((add bb (XO ab)), bb)))
         | XO b0 ->
           let (g, p) = ggcdn n0 a b0 in
           let (aa, bb) = p in (g, (aa, (XO bb)))
         | XH -> (XH, (a, XH)))
      | XO a0 ->
        (match b with
         | XI _ ->
           let (g, p) = ggcdn n0 a0 b in
           let (aa, bb) = p in (g, ((XO aa), bb))
         | XO b0 -> let (g, p) = ggcdn n0 a0 b0 in ((XO g), p)
         | XH -> (XH, (a, XH)))
      | XH -> (XH, (XH, b)))
      n

  (** val ggcd : positive -> positive -> positive * (positive * positive) **)

  let ggcd a b =
    ggcdn (Coq__1.add (size_nat a) (size_nat b)) a b

  (** val iter_op : ('a1 -> 'a1 -> 'a1) -> positive -> 'a1 -> 'a1 **)

  let rec iter_op op p a =
    match p with
    | XI p0 -> op a (iter_op op p0 (op a a))
    | XO p0 -> iter_op op p0 (op a a)
    | XH -> a

  (** val to_nat : positive -> int **)

  let to_nat x =
    iter_op Coq__1.add x (Stdlib.Int.succ 0)

  (** val of_nat : int -> positive **)

  let rec of_nat n =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> XH)
      (fun x ->
      (fun fO fS n -> if n=0 then fO () else fS (n-1))
        (fun _ -> XH)
        (fun _ -> succ (of_nat x))
        x)
      n

  (** val of_succ_nat : int -> positive **)

  let rec of_succ_nat n =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> XH)
      (fun x -> succ (of_succ_nat x))
      n
 end

module Z =
 struct
  (** val double : z -> z **)

  let double = function
  | Z0 -> Z0
  | Zpos p -> Zpos (XO p)
  | Zneg p -> Zneg (XO p)

  (** val succ_double : z -> z **)

  let succ_double = function
  | Z0 -> Zpos XH
  | Zpos p -> Zpos (XI p)
  | Zneg p -> Zneg (Coq_Pos.pred_double p)

  (** val pred_double : z -> z **)

  let pred_double = function
  | Z0 -> Zneg XH
  | Zpos p -> Zpos (Coq_Pos.pred_double p)
  | Zneg p -> Zneg (XI p)

  (** val pos_sub : positive -> positive -> z **)

  let rec pos_sub x y =
    match x with
    | XI p ->
      (match y with
       | XI q0 -> double (pos_sub p q0)
       | XO q0 -> succ_double (pos_sub p q0)
       | XH -> Zpos (XO p))
    | XO p ->
      (match y with
       | XI q0 -> pred_double (pos_sub p q0)
       | XO q0 -> double (pos_sub p q0)
       | XH -> Zpos (Coq_Pos.pred_double p))
    | XH ->
      (match y with
       | XI q0 -> Zneg (XO q0)
       | XO q0 -> Zneg (Coq_Pos.pred_double q0)
       | XH -> Z0)

  (** val add : z -> z -> z **)

  let add x y =
    match x with
    | Z0 -> y
    | Zpos x' ->
      (match y with
       | Z0 -> x
       | Zpos y' -> Zpos (Coq_Pos.add x' y')
       | Zneg y' -> pos_sub x' y')
    | Zneg x' ->
      (match y with
       | Z0 -> x
       | Zpos y' -> pos_sub y' x'
       | Zneg y' -> Zneg (Coq_Pos.add x' y'))

  (** val opp : z -> z **)

  let opp = function
  | Z0 -> Z0
  | Zpos x0 -> Zneg x0
  | Zneg x0 -> Zpos x0

  (** val sub : z -> z -> z **)

  let sub m n =
    add m (opp n)

  (** val mul : z -> z -> z **)

  let mul x y =
    match x with
    | Z0 -> Z0
    | Zpos x' ->
      (match y with
       | Z0 -> Z0
       | Zpos y' -> Zpos (Coq_Pos.mul x' y')
       | Zneg y' -> Zneg (Coq_Pos.mul x' y'))
    | Zneg x' ->
      (match y with
       | Z0 -> Z0
       | Zpos y' -> Zneg (Coq_Pos.mul x' y')
       | Zneg y' -> Zpos (Coq_Pos.mul x' y'))

  (** val pow_pos : z -> positive -> z **)

  let pow_pos z0 =
    Coq_Pos.iter (mul z0) (Zpos XH)

  (** val compare : z -> z -> comparison **)

  let compare x y =
    match x with
    | Z0 -> (match y with
             | Z0 -> Eq
             | Zpos _ -> Lt
             | Zneg _ -> Gt)
    | Zpos x' -> (match y with
                  | Zpos y' -> Coq_Pos.compare x' y'
                  | _ -> Gt)
    | Zneg x' ->
      (match y with
       | Zneg y' -> compOpp (Coq_Pos.compare x' y')
       | _ -> Lt)

  (** val sgn : z -> z **)

  let sgn = function
  | Z0 -> Z0
  | Zpos _ -> Zpos XH
  | Zneg _ -> Zneg XH

  (** val max : z -> z -> z **)

  let max n m =
    match compare n m with
    | Lt -> m
    | _ -> n

  (** val min : z -> z -> z **)

  let min n m =
    match compare n m with
    | Gt -> m
    | _ -> n

  (** val abs : z -> z **)

  let abs = function
  | Zneg p -> Zpos p
  | x -> x

  (** val to_nat : z -> int **)

  let to_nat = function
  | Zpos p -> Coq_Pos.to_nat p
  | _ -> 0

  (** val of_nat : int -> z **)

  let of_nat n =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ -> Z0)
      (fun n0 -> Zpos (Coq_Pos.of_succ_nat n0))
      n

  (** val to_pos : z -> positive **)

  let to_pos = function
  | Zpos p -> p
  | _ -> XH

  (** val ggcd : z -> z -> z * (z * z) **)

  let ggcd a b =
    match a with
    | Z0 -> ((abs b), (Z0, (sgn b)))
    | Zpos a0 ->
      (match b with
       | Z0 -> ((abs a), ((sgn a), Z0))
       | Zpos b0 ->
         let (g, p) = Coq_Pos.ggcd a0 b0 in
         let (aa, bb) = p in ((Zpos g), ((Zpos aa), (Zpos bb)))
       | Zneg b0 ->
         let (g, p) = Coq_Pos.ggcd a0 b0 in
         let (aa, bb) = p in ((Zpos g), ((Zpos aa), (Zneg bb))))
    | Zneg a0 ->
      (match b with
       | Z0 -> ((abs a), ((sgn a), Z0))
       | Zpos b0 ->
         let (g, p) = Coq_Pos.ggcd a0 b0 in
         let (aa, bb) = p in ((Zpos g), ((Zneg aa), (Zpos bb)))
       | Zneg b0 ->
         let (g, p) = Coq_Pos.ggcd a0 b0 in
         let (aa, bb) = p in ((Zpos g), ((Zneg aa), (Zneg bb))))
 end

(** val z_lt_dec : z -> z -> bool **)

let z_lt_dec x y =
  match Z.compare x y with
  | Lt -> true
  | _ -> false

(** val z_lt_ge_dec : z -> z -> bool **)

let z_lt_ge_dec =
  z_lt_dec

(** val z_lt_le_dec : z -> z -> bool **)

let z_lt_le_dec =
  z_lt_ge_dec

(** val pow_pos0 : ('a1 -> 'a1 -> 'a1) -> 'a1 -> positive -> 'a1 **)

let rec pow_pos0 rmul x = function
| XI i0 -> let p = pow_pos0 rmul x i0 in rmul x (rmul p p)
| XO i0 -> let p = pow_pos0 rmul x i0 in rmul p p
| XH -> x

type q = { qnum : z; qden : positive }

(** val qplus : q -> q -> q **)

let qplus x y =
  { qnum = (Z.add (Z.mul x.qnum (Zpos y.qden)) (Z.mul y.qnum (Zpos x.qden)));
    qden = (Coq_Pos.mul x.qden y.qden) }

(** val qmult : q -> q -> q **)

let qmult x y =
  { qnum = (Z.mul x.qnum y.qnum); qden = (Coq_Pos.mul x.qden y.qden) }

(** val qopp : q -> q **)

let qopp x =
  { qnum = (Z.opp x.qnum); qden = x.qden }

(** val qminus : q -> q -> q **)

let qminus x y =
  qplus x (qopp y)

(** val qinv : q -> q **)

let qinv x =
  match x.qnum with
  | Z0 -> { qnum = Z0; qden = XH }
  | Zpos p -> { qnum = (Zpos x.qden); qden = p }
  | Zneg p -> { qnum = (Zneg x.qden); qden = p }

(** val qlt_le_dec : q -> q -> bool **)

let qlt_le_dec x y =
  z_lt_le_dec (Z.mul x.qnum (Zpos y.qden)) (Z.mul y.qnum (Zpos x.qden))

(** val qarchimedean : q -> positive **)

let qarchimedean q0 =
  let { qnum = qnum0; qden = _ } = q0 in
  (match qnum0 with
   | Zpos p -> Coq_Pos.add p XH
   | _ -> XH)

(** val qpower_positive : q -> positive -> q **)

let qpower_positive =
  pow_pos0 qmult

(** val qpower : q -> z -> q **)

let qpower q0 = function
| Z0 -> { qnum = (Zpos XH); qden = XH }
| Zpos p -> qpower_positive q0 p
| Zneg p -> qinv (qpower_positive q0 p)

(** val qred : q -> q **)

let qred q0 =
  let { qnum = q1; qden = q2 } = q0 in
  let (r1, r2) = snd (Z.ggcd q1 (Zpos q2)) in
  { qnum = r1; qden = (Z.to_pos r2) }

(** val qabs : q -> q **)

let qabs x =
  let { qnum = n; qden = d } = x in { qnum = (Z.abs n); qden = d }

(** val linear_search_conform : (int -> bool) -> int -> int **)

let rec linear_search_conform p_dec start =
  if p_dec start
  then start
  else linear_search_conform p_dec (Stdlib.Int.succ start)

(** val linear_search_from_0_conform : (int -> bool) -> int **)

let linear_search_from_0_conform p_dec =
  linear_search_conform p_dec 0

(** val constructive_indefinite_ground_description_nat :
    (int -> bool) -> int **)

let constructive_indefinite_ground_description_nat =
  linear_search_from_0_conform

(** val p'_decidable : (int -> 'a1) -> ('a1 -> bool) -> int -> bool **)

let p'_decidable g p_decidable n =
  p_decidable (g n)

(** val constructive_indefinite_ground_description :
    ('a1 -> int) -> (int -> 'a1) -> ('a1 -> bool) -> 'a1 **)

let constructive_indefinite_ground_description _ g p_decidable =
  let h1 =
    constructive_indefinite_ground_description_nat
      (p'_decidable g p_decidable)
  in
  g h1

(** val pos_log2floor_plus1 : positive -> positive **)

let rec pos_log2floor_plus1 = function
| XI p' -> Coq_Pos.succ (pos_log2floor_plus1 p')
| XO p' -> Coq_Pos.succ (pos_log2floor_plus1 p')
| XH -> XH

(** val qbound_lt_ZExp2 : q -> z **)

let qbound_lt_ZExp2 q0 =
  match q0.qnum with
  | Z0 -> Zneg (XO (XO (XO (XI (XO (XI (XI (XI (XI XH)))))))))
  | Zpos p ->
    Z.pos_sub (Coq_Pos.succ (pos_log2floor_plus1 p))
      (pos_log2floor_plus1 q0.qden)
  | Zneg _ -> Z0

(** val qbound_ltabs_ZExp2 : q -> z **)

let qbound_ltabs_ZExp2 q0 =
  qbound_lt_ZExp2 (qabs q0)

(** val z_inj_nat : z -> int **)

let z_inj_nat = function
| Z0 -> 0
| Zpos p -> Coq_Pos.to_nat (XO p)
| Zneg p -> Coq_Pos.to_nat (Coq_Pos.pred_double p)

(** val z_inj_nat_rev : int -> z **)

let z_inj_nat_rev n =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> Z0)
    (fun _ ->
    match Coq_Pos.of_nat n with
    | XI p -> Zneg (Coq_Pos.succ p)
    | XO p -> Zpos p
    | XH -> Zneg XH)
    n

(** val constructive_indefinite_ground_description_Z : (z -> bool) -> z **)

let constructive_indefinite_ground_description_Z x =
  constructive_indefinite_ground_description z_inj_nat z_inj_nat_rev x

type cReal = { seq : (z -> q); scale : z }

type cRealLt = z

type cReal_appart = (cRealLt, cRealLt) sum

(** val cRealLt_lpo_dec :
    cReal -> cReal -> (__ -> (int -> bool) -> int option) -> (cRealLt, __) sum **)

let cRealLt_lpo_dec x y lpo =
  let s =
    lpo __ (fun n ->
      let s =
        qlt_le_dec
          (qmult { qnum = (Zpos (XO XH)); qden = XH }
            (qpower { qnum = (Zpos (XO XH)); qden = XH } (z_inj_nat_rev n)))
          (qminus (y.seq (z_inj_nat_rev n)) (x.seq (z_inj_nat_rev n)))
      in
      if s then false else true)
  in
  (match s with
   | Some s0 -> Inl (z_inj_nat_rev s0)
   | None -> Inr __)

(** val inject_Q : q -> cReal **)

let inject_Q q0 =
  { seq = (fun _ -> q0); scale = (qbound_ltabs_ZExp2 q0) }

(** val cReal_plus_seq : cReal -> cReal -> z -> q **)

let cReal_plus_seq x y n =
  qred (qplus (x.seq (Z.sub n (Zpos XH))) (y.seq (Z.sub n (Zpos XH))))

(** val cReal_plus_scale : cReal -> cReal -> z **)

let cReal_plus_scale x y =
  Z.add (Z.max x.scale y.scale) (Zpos XH)

(** val cReal_plus : cReal -> cReal -> cReal **)

let cReal_plus x y =
  { seq = (cReal_plus_seq x y); scale = (cReal_plus_scale x y) }

(** val cReal_opp_seq : cReal -> z -> q **)

let cReal_opp_seq x n =
  qopp (x.seq n)

(** val cReal_opp_scale : cReal -> z **)

let cReal_opp_scale x =
  x.scale

(** val cReal_opp : cReal -> cReal **)

let cReal_opp x =
  { seq = (cReal_opp_seq x); scale = (cReal_opp_scale x) }

(** val cReal_mult_seq : cReal -> cReal -> z -> q **)

let cReal_mult_seq x y n =
  qmult (x.seq (Z.sub (Z.sub n y.scale) (Zpos XH)))
    (y.seq (Z.sub (Z.sub n x.scale) (Zpos XH)))

(** val cReal_mult_scale : cReal -> cReal -> z **)

let cReal_mult_scale x y =
  Z.add x.scale y.scale

(** val cReal_mult : cReal -> cReal -> cReal **)

let cReal_mult x y =
  { seq = (cReal_mult_seq x y); scale = (cReal_mult_scale x y) }

(** val cRealLowerBound : cReal -> cRealLt -> z **)

let cRealLowerBound _ xPos =
  xPos

(** val cReal_inv_pos_cm : cReal -> cRealLt -> z -> z **)

let cReal_inv_pos_cm x xPos n =
  Z.min (cRealLowerBound x xPos)
    (Z.add n (Z.mul (Zpos (XO XH)) (cRealLowerBound x xPos)))

(** val cReal_inv_pos_seq : cReal -> cRealLt -> z -> q **)

let cReal_inv_pos_seq x xPos n =
  qinv (x.seq (cReal_inv_pos_cm x xPos n))

(** val cReal_inv_pos_scale : cReal -> cRealLt -> z **)

let cReal_inv_pos_scale x xPos =
  Z.opp (cRealLowerBound x xPos)

(** val cReal_inv_pos : cReal -> cRealLt -> cReal **)

let cReal_inv_pos x hxpos =
  { seq = (cReal_inv_pos_seq x hxpos); scale = (cReal_inv_pos_scale x hxpos) }

(** val cReal_neg_lt_pos : cReal -> cRealLt -> cRealLt **)

let cReal_neg_lt_pos _ h =
  h

(** val cReal_inv : cReal -> cReal_appart -> cReal **)

let cReal_inv x = function
| Inl xNeg ->
  cReal_opp (cReal_inv_pos (cReal_opp x) (cReal_neg_lt_pos x xNeg))
| Inr xPos -> cReal_inv_pos x xPos

(** val cRealLtDisjunctEpsilon :
    cReal -> cReal -> cReal -> cReal -> (cRealLt, cRealLt) sum **)

let cRealLtDisjunctEpsilon a b c d =
  let h0 =
    constructive_indefinite_ground_description_Z (fun n ->
      let s =
        qlt_le_dec
          (qmult { qnum = (Zpos (XO XH)); qden = XH }
            (qpower { qnum = (Zpos (XO XH)); qden = XH } n))
          (qminus (b.seq n) (a.seq n))
      in
      if s
      then true
      else qlt_le_dec
             (qmult { qnum = (Zpos (XO XH)); qden = XH }
               (qpower { qnum = (Zpos (XO XH)); qden = XH } n))
             (qminus (d.seq n) (c.seq n)))
  in
  let s =
    qlt_le_dec
      (qmult { qnum = (Zpos (XO XH)); qden = XH }
        (qpower { qnum = (Zpos (XO XH)); qden = XH } h0))
      (qminus (b.seq h0) (a.seq h0))
  in
  if s then Inl h0 else Inr h0

(** val sig_forall_dec : (int -> bool) -> int option **)

let sig_forall_dec =
  failwith "AXIOM TO BE REALIZED"

(** val lowerCutBelow : (q -> bool) -> q **)

let lowerCutBelow f =
  let s =
    sig_forall_dec (fun _ ->
      let b = f (qopp { qnum = (Z.of_nat 0); qden = XH }) in
      not b)
  in
  (match s with
   | Some s0 -> qopp { qnum = (Z.of_nat s0); qden = XH }
   | None -> assert false (* absurd case *))

(** val lowerCutAbove : (q -> bool) -> q **)

let lowerCutAbove f =
  let s =
    sig_forall_dec (fun _ ->
      let b = f { qnum = (Z.of_nat 0); qden = XH } in
      b)
  in
  (match s with
   | Some s0 -> { qnum = (Z.of_nat s0); qden = XH }
   | None -> assert false (* absurd case *))

type dReal = (q -> bool)

(** val dRealQlim_rec : (q -> bool) -> int -> int -> q **)

let rec dRealQlim_rec f n p =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> assert false (* absurd case *))
    (fun n0 ->
    let b =
      f
        (qplus (lowerCutBelow f) { qnum = (Z.of_nat n0); qden =
          (Coq_Pos.of_nat (Stdlib.Int.succ n)) })
    in
    if b
    then qplus (lowerCutBelow f) { qnum = (Z.of_nat n0); qden =
           (Coq_Pos.of_nat (Stdlib.Int.succ n)) }
    else dRealQlim_rec f n n0)
    p

(** val dRealAbstr : cReal -> dReal **)

let dRealAbstr x =
  let h = fun q0 n ->
    let s =
      qlt_le_dec
        (qplus q0
          (qpower { qnum = (Zpos (XO XH)); qden = XH } (Z.opp (Z.of_nat n))))
        (x.seq (Z.opp (Z.of_nat n)))
    in
    not s
  in
  (fun q0 -> match sig_forall_dec (h q0) with
             | Some _ -> true
             | None -> false)

(** val dRealQlim : dReal -> int -> q **)

let dRealQlim x n =
  let s = lowerCutAbove x in
  let s0 = qarchimedean (qminus s (lowerCutBelow x)) in
  dRealQlim_rec x n (mul (Stdlib.Int.succ n) (Coq_Pos.to_nat s0))

(** val dRealQlimExp2 : dReal -> int -> q **)

let dRealQlimExp2 x n =
  dRealQlim x (pred (Nat.pow (Stdlib.Int.succ (Stdlib.Int.succ 0)) n))

(** val cReal_of_DReal_seq : dReal -> z -> q **)

let cReal_of_DReal_seq x n =
  dRealQlimExp2 x (Z.to_nat (Z.opp n))

(** val cReal_of_DReal_scale : dReal -> z **)

let cReal_of_DReal_scale x =
  qbound_lt_ZExp2
    (qplus (qabs (cReal_of_DReal_seq x (Zneg XH))) { qnum = (Zpos (XO XH));
      qden = XH })

(** val dRealRepr : dReal -> cReal **)

let dRealRepr x =
  { seq = (cReal_of_DReal_seq x); scale = (cReal_of_DReal_scale x) }

module type RbaseSymbolsSig =
 sig
  type coq_R

  val coq_Rabst : cReal -> coq_R

  val coq_Rrepr : coq_R -> cReal

  val coq_R0 : coq_R

  val coq_R1 : coq_R

  val coq_Rplus : coq_R -> coq_R -> coq_R

  val coq_Rmult : coq_R -> coq_R -> coq_R

  val coq_Ropp : coq_R -> coq_R
 end

module RbaseSymbolsImpl =
 struct
  type coq_R = dReal

  (** val coq_Rabst : cReal -> dReal **)

  let coq_Rabst =
    dRealAbstr

  (** val coq_Rrepr : dReal -> cReal **)

  let coq_Rrepr =
    dRealRepr

  (** val coq_Rquot1 : __ **)

  let coq_Rquot1 =
    __

  (** val coq_Rquot2 : __ **)

  let coq_Rquot2 =
    __

  (** val coq_R0 : coq_R **)

  let coq_R0 =
    coq_Rabst (inject_Q { qnum = Z0; qden = XH })

  (** val coq_R1 : coq_R **)

  let coq_R1 =
    coq_Rabst (inject_Q { qnum = (Zpos XH); qden = XH })

  (** val coq_Rplus : coq_R -> coq_R -> coq_R **)

  let coq_Rplus x y =
    coq_Rabst (cReal_plus (coq_Rrepr x) (coq_Rrepr y))

  (** val coq_Rmult : coq_R -> coq_R -> coq_R **)

  let coq_Rmult x y =
    coq_Rabst (cReal_mult (coq_Rrepr x) (coq_Rrepr y))

  (** val coq_Ropp : coq_R -> coq_R **)

  let coq_Ropp x =
    coq_Rabst (cReal_opp (coq_Rrepr x))

  type coq_Rlt = __

  (** val coq_R0_def : __ **)

  let coq_R0_def =
    __

  (** val coq_R1_def : __ **)

  let coq_R1_def =
    __

  (** val coq_Rplus_def : __ **)

  let coq_Rplus_def =
    __

  (** val coq_Rmult_def : __ **)

  let coq_Rmult_def =
    __

  (** val coq_Ropp_def : __ **)

  let coq_Ropp_def =
    __

  (** val coq_Rlt_def : __ **)

  let coq_Rlt_def =
    __
 end

(** val rminus :
    RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R **)

let rminus r1 r2 =
  RbaseSymbolsImpl.coq_Rplus r1 (RbaseSymbolsImpl.coq_Ropp r2)

(** val iPR_2 : positive -> RbaseSymbolsImpl.coq_R **)

let rec iPR_2 = function
| XI p0 ->
  RbaseSymbolsImpl.coq_Rmult
    (RbaseSymbolsImpl.coq_Rplus RbaseSymbolsImpl.coq_R1
      RbaseSymbolsImpl.coq_R1)
    (RbaseSymbolsImpl.coq_Rplus RbaseSymbolsImpl.coq_R1 (iPR_2 p0))
| XO p0 ->
  RbaseSymbolsImpl.coq_Rmult
    (RbaseSymbolsImpl.coq_Rplus RbaseSymbolsImpl.coq_R1
      RbaseSymbolsImpl.coq_R1) (iPR_2 p0)
| XH ->
  RbaseSymbolsImpl.coq_Rplus RbaseSymbolsImpl.coq_R1 RbaseSymbolsImpl.coq_R1

(** val iPR : positive -> RbaseSymbolsImpl.coq_R **)

let iPR = function
| XI p0 -> RbaseSymbolsImpl.coq_Rplus RbaseSymbolsImpl.coq_R1 (iPR_2 p0)
| XO p0 -> iPR_2 p0
| XH -> RbaseSymbolsImpl.coq_R1

(** val iZR : z -> RbaseSymbolsImpl.coq_R **)

let iZR = function
| Z0 -> RbaseSymbolsImpl.coq_R0
| Zpos n -> iPR n
| Zneg n -> RbaseSymbolsImpl.coq_Ropp (iPR n)

(** val total_order_T :
    RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool option **)

let total_order_T r1 r2 =
  let s =
    cRealLt_lpo_dec (RbaseSymbolsImpl.coq_Rrepr r1)
      (RbaseSymbolsImpl.coq_Rrepr r2) (fun _ -> sig_forall_dec)
  in
  (match s with
   | Inl _ -> Some true
   | Inr _ ->
     let s0 =
       cRealLt_lpo_dec (RbaseSymbolsImpl.coq_Rrepr r2)
         (RbaseSymbolsImpl.coq_Rrepr r1) (fun _ -> sig_forall_dec)
     in
     (match s0 with
      | Inl _ -> None
      | Inr _ -> Some false))

(** val req_appart_dec :
    RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool **)

let req_appart_dec x y =
  let s = total_order_T x y in
  (match s with
   | Some s0 -> if s0 then false else true
   | None -> false)

(** val rrepr_appart_0 : RbaseSymbolsImpl.coq_R -> cReal_appart **)

let rrepr_appart_0 x =
  cRealLtDisjunctEpsilon (RbaseSymbolsImpl.coq_Rrepr x)
    (inject_Q { qnum = Z0; qden = XH }) (inject_Q { qnum = Z0; qden = XH })
    (RbaseSymbolsImpl.coq_Rrepr x)

module type RinvSig =
 sig
  val coq_Rinv : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R
 end

module RinvImpl =
 struct
  (** val coq_Rinv : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R **)

  let coq_Rinv x =
    if req_appart_dec x RbaseSymbolsImpl.coq_R0
    then RbaseSymbolsImpl.coq_R0
    else RbaseSymbolsImpl.coq_Rabst
           (cReal_inv (RbaseSymbolsImpl.coq_Rrepr x) (rrepr_appart_0 x))

  (** val coq_Rinv_def : __ **)

  let coq_Rinv_def =
    __
 end

(** val rlt_dec : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool **)

let rlt_dec r1 r2 =
  let s = total_order_T r1 r2 in (match s with
                                  | Some s0 -> s0
                                  | None -> false)

(** val rle_dec : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool **)

let rle_dec r1 r2 =
  let s = rlt_dec r2 r1 in if s then false else true

(** val rmin :
    RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R **)

let rmin x y =
  if rle_dec x y then x else y

(** val rcase_abs : RbaseSymbolsImpl.coq_R -> bool **)

let rcase_abs r =
  let x = rle_dec (iZR Z0) r in if x then false else true

(** val rabs : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R **)

let rabs r =
  if rcase_abs r then RbaseSymbolsImpl.coq_Ropp r else r

type spec_float =
| S754_zero of bool
| S754_infinity of bool
| S754_nan
| S754_finite of bool * positive * z

(** val sFcompare : spec_float -> spec_float -> comparison option **)

let sFcompare f1 f2 =
  match f1 with
  | S754_zero _ ->
    (match f2 with
     | S754_zero _ -> Some Eq
     | S754_infinity s -> Some (if s then Gt else Lt)
     | S754_nan -> None
     | S754_finite (s, _, _) -> Some (if s then Gt else Lt))
  | S754_infinity s ->
    (match f2 with
     | S754_infinity s0 ->
       Some (if s then if s0 then Eq else Lt else if s0 then Gt else Eq)
     | S754_nan -> None
     | _ -> Some (if s then Lt else Gt))
  | S754_nan -> None
  | S754_finite (s1, m1, e1) ->
    (match f2 with
     | S754_zero _ -> Some (if s1 then Lt else Gt)
     | S754_infinity s -> Some (if s then Gt else Lt)
     | S754_nan -> None
     | S754_finite (s2, m2, e2) ->
       Some
         (if s1
          then if s2
               then (match Z.compare e1 e2 with
                     | Eq -> compOpp (Coq_Pos.compare_cont Eq m1 m2)
                     | Lt -> Gt
                     | Gt -> Lt)
               else Lt
          else if s2
               then Gt
               else (match Z.compare e1 e2 with
                     | Eq -> Coq_Pos.compare_cont Eq m1 m2
                     | x -> x)))

(** val cond_Zopp : bool -> z -> z **)

let cond_Zopp b m =
  if b then Z.opp m else m

type radix = z
  (* singleton inductive, whose constructor was Build_radix *)

(** val radix_val : radix -> z **)

let radix_val r =
  r

(** val radix2 : radix **)

let radix2 =
  Zpos (XO XH)

(** val bpow : radix -> z -> RbaseSymbolsImpl.coq_R **)

let bpow r = function
| Z0 -> iZR (Zpos XH)
| Zpos p -> iZR (Z.pow_pos (radix_val r) p)
| Zneg p -> RinvImpl.coq_Rinv (iZR (Z.pow_pos (radix_val r) p))

type float = { fnum : z; fexp : z }

(** val f2R : radix -> float -> RbaseSymbolsImpl.coq_R **)

let f2R beta f =
  RbaseSymbolsImpl.coq_Rmult (iZR f.fnum) (bpow beta f.fexp)

type binary_float =
| B754_zero of bool
| B754_infinity of bool
| B754_nan
| B754_finite of bool * positive * z

(** val b2SF : z -> z -> binary_float -> spec_float **)

let b2SF _ _ = function
| B754_zero s -> S754_zero s
| B754_infinity s -> S754_infinity s
| B754_nan -> S754_nan
| B754_finite (s, m, e) -> S754_finite (s, m, e)

(** val bcompare :
    z -> z -> binary_float -> binary_float -> comparison option **)

let bcompare prec emax f1 f2 =
  sFcompare (b2SF prec emax f1) (b2SF prec emax f2)

type binary_float0 =
| B754_zero0 of bool
| B754_infinity0 of bool
| B754_nan0 of bool * positive
| B754_finite0 of bool * positive * z

(** val b2BSN : z -> z -> binary_float0 -> binary_float **)

let b2BSN _ _ = function
| B754_zero0 s -> B754_zero s
| B754_infinity0 s -> B754_infinity s
| B754_nan0 (_, _) -> B754_nan
| B754_finite0 (s, m, e) -> B754_finite (s, m, e)

(** val b2R : z -> z -> binary_float0 -> RbaseSymbolsImpl.coq_R **)

let b2R _ _ = function
| B754_finite0 (s, m, e) ->
  f2R radix2 { fnum = (cond_Zopp s (Zpos m)); fexp = e }
| _ -> iZR Z0

(** val bcompare0 :
    z -> z -> binary_float0 -> binary_float0 -> comparison option **)

let bcompare0 prec emax f1 f2 =
  bcompare prec emax (b2BSN prec emax f1) (b2BSN prec emax f2)

type float64 = binary_float0

type verifiedBoundary = { lower_rational : q; upper_rational : q;
                          lower_float : float64; upper_float : float64;
                          category : char list }

type verifiedDomain = { domain_name : char list;
                        measurement_unit : char list;
                        boundaries : verifiedBoundary list;
                        global_bounds : (float64 * float64);
                        domain_precision_bound : RbaseSymbolsImpl.coq_R }

(** val b2R64 : float64 -> RbaseSymbolsImpl.coq_R **)

let b2R64 f =
  b2R (Zpos (XI (XO (XI (XO (XI XH)))))) (Zpos (XO (XO (XO (XO (XO (XO (XO
    (XO (XO (XO XH))))))))))) f

(** val in_boundary_range : float64 -> verifiedBoundary -> bool **)

let in_boundary_range x b =
  match bcompare0 (Zpos (XI (XO (XI (XO (XI XH)))))) (Zpos (XO (XO (XO (XO
          (XO (XO (XO (XO (XO (XO XH))))))))))) b.lower_float x with
  | Some c ->
    (match c with
     | Eq -> true
     | Lt ->
       (match bcompare0 (Zpos (XI (XO (XI (XO (XI XH)))))) (Zpos (XO (XO (XO
                (XO (XO (XO (XO (XO (XO (XO XH))))))))))) x b.upper_float with
        | Some c0 -> (match c0 with
                      | Gt -> false
                      | _ -> true)
        | None -> false)
     | Gt -> false)
  | None -> false

(** val find_category_flocq :
    verifiedBoundary list -> float64 -> char list option **)

let rec find_category_flocq boundaries0 x =
  match boundaries0 with
  | [] -> None
  | b :: rest ->
    if in_boundary_range x b
    then Some b.category
    else find_category_flocq rest x

(** val classify_flocq : verifiedDomain -> float64 -> char list **)

let classify_flocq domain input =
  match find_category_flocq domain.boundaries input with
  | Some category0 -> category0
  | None ->
    'C'::('L'::('A'::('S'::('S'::('I'::('F'::('I'::('C'::('A'::('T'::('I'::('O'::('N'::('_'::('E'::('R'::('R'::('O'::('R'::[])))))))))))))))))))

(** val boundary_distance_flocq :
    float64 -> verifiedBoundary -> RbaseSymbolsImpl.coq_R **)

let boundary_distance_flocq x b =
  let x_real = b2R64 x in
  let lower_real = b2R64 b.lower_float in
  let upper_real = b2R64 b.upper_float in
  let dist_lower = rabs (rminus x_real lower_real) in
  let dist_upper = rabs (rminus x_real upper_real) in
  rmin dist_lower dist_upper

(** val confidence_level_flocq : verifiedDomain -> float64 -> int **)

let confidence_level_flocq _ _ =
  Stdlib.Int.succ (Stdlib.Int.succ 0)

let verify_file (filename : string) : bool =
  try
    let _ = Yojson.Basic.from_file filename in
    true
  with _ -> false
