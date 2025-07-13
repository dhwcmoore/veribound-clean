
type __ = Obj.t

type ('a, 'b) sum =
| Inl of 'a
| Inr of 'b

val snd : ('a1 * 'a2) -> 'a2

type comparison =
| Eq
| Lt
| Gt

val compOpp : comparison -> comparison

type 'a sig0 = 'a
  (* singleton inductive, whose constructor was exist *)



val pred : int -> int

val add : int -> int -> int

val mul : int -> int -> int

type positive =
| XI of positive
| XO of positive
| XH

type z =
| Z0
| Zpos of positive
| Zneg of positive

module Nat :
 sig
  val add : int -> int -> int

  val mul : int -> int -> int

  val pow : int -> int -> int
 end

module Pos :
 sig
  type mask =
  | IsNul
  | IsPos of positive
  | IsNeg
 end

module Coq_Pos :
 sig
  val succ : positive -> positive

  val add : positive -> positive -> positive

  val add_carry : positive -> positive -> positive

  val pred_double : positive -> positive

  type mask = Pos.mask =
  | IsNul
  | IsPos of positive
  | IsNeg

  val succ_double_mask : mask -> mask

  val double_mask : mask -> mask

  val double_pred_mask : positive -> mask

  val sub_mask : positive -> positive -> mask

  val sub_mask_carry : positive -> positive -> mask

  val sub : positive -> positive -> positive

  val mul : positive -> positive -> positive

  val iter : ('a1 -> 'a1) -> 'a1 -> positive -> 'a1

  val size_nat : positive -> int

  val compare_cont : comparison -> positive -> positive -> comparison

  val compare : positive -> positive -> comparison

  val ggcdn : int -> positive -> positive -> positive * (positive * positive)

  val ggcd : positive -> positive -> positive * (positive * positive)

  val iter_op : ('a1 -> 'a1 -> 'a1) -> positive -> 'a1 -> 'a1

  val to_nat : positive -> int

  val of_nat : int -> positive

  val of_succ_nat : int -> positive
 end

module Z :
 sig
  val double : z -> z

  val succ_double : z -> z

  val pred_double : z -> z

  val pos_sub : positive -> positive -> z

  val add : z -> z -> z

  val opp : z -> z

  val sub : z -> z -> z

  val mul : z -> z -> z

  val pow_pos : z -> positive -> z

  val compare : z -> z -> comparison

  val sgn : z -> z

  val max : z -> z -> z

  val min : z -> z -> z

  val abs : z -> z

  val to_nat : z -> int

  val of_nat : int -> z

  val to_pos : z -> positive

  val ggcd : z -> z -> z * (z * z)
 end

val z_lt_dec : z -> z -> bool

val z_lt_ge_dec : z -> z -> bool

val z_lt_le_dec : z -> z -> bool

val pow_pos0 : ('a1 -> 'a1 -> 'a1) -> 'a1 -> positive -> 'a1

type q = { qnum : z; qden : positive }

val qplus : q -> q -> q

val qmult : q -> q -> q

val qopp : q -> q

val qminus : q -> q -> q

val qinv : q -> q

val qlt_le_dec : q -> q -> bool

val qarchimedean : q -> positive

val qpower_positive : q -> positive -> q

val qpower : q -> z -> q

val qred : q -> q

val qabs : q -> q

val linear_search_conform : (int -> bool) -> int -> int

val linear_search_from_0_conform : (int -> bool) -> int

val constructive_indefinite_ground_description_nat : (int -> bool) -> int

val p'_decidable : (int -> 'a1) -> ('a1 -> bool) -> int -> bool

val constructive_indefinite_ground_description :
  ('a1 -> int) -> (int -> 'a1) -> ('a1 -> bool) -> 'a1

val pos_log2floor_plus1 : positive -> positive

val qbound_lt_ZExp2 : q -> z

val qbound_ltabs_ZExp2 : q -> z

val z_inj_nat : z -> int

val z_inj_nat_rev : int -> z

val constructive_indefinite_ground_description_Z : (z -> bool) -> z

type cReal = { seq : (z -> q); scale : z }

type cRealLt = z

type cReal_appart = (cRealLt, cRealLt) sum

val cRealLt_lpo_dec :
  cReal -> cReal -> (__ -> (int -> bool) -> int option) -> (cRealLt, __) sum

val inject_Q : q -> cReal

val cReal_plus_seq : cReal -> cReal -> z -> q

val cReal_plus_scale : cReal -> cReal -> z

val cReal_plus : cReal -> cReal -> cReal

val cReal_opp_seq : cReal -> z -> q

val cReal_opp_scale : cReal -> z

val cReal_opp : cReal -> cReal

val cReal_mult_seq : cReal -> cReal -> z -> q

val cReal_mult_scale : cReal -> cReal -> z

val cReal_mult : cReal -> cReal -> cReal

val cRealLowerBound : cReal -> cRealLt -> z

val cReal_inv_pos_cm : cReal -> cRealLt -> z -> z

val cReal_inv_pos_seq : cReal -> cRealLt -> z -> q

val cReal_inv_pos_scale : cReal -> cRealLt -> z

val cReal_inv_pos : cReal -> cRealLt -> cReal

val cReal_neg_lt_pos : cReal -> cRealLt -> cRealLt

val cReal_inv : cReal -> cReal_appart -> cReal

val cRealLtDisjunctEpsilon :
  cReal -> cReal -> cReal -> cReal -> (cRealLt, cRealLt) sum

val sig_forall_dec : (int -> bool) -> int option

val lowerCutBelow : (q -> bool) -> q

val lowerCutAbove : (q -> bool) -> q

type dReal = (q -> bool)

val dRealQlim_rec : (q -> bool) -> int -> int -> q

val dRealAbstr : cReal -> dReal

val dRealQlim : dReal -> int -> q

val dRealQlimExp2 : dReal -> int -> q

val cReal_of_DReal_seq : dReal -> z -> q

val cReal_of_DReal_scale : dReal -> z

val dRealRepr : dReal -> cReal

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

module RbaseSymbolsImpl :
 RbaseSymbolsSig

val rminus :
  RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R

val iPR_2 : positive -> RbaseSymbolsImpl.coq_R

val iPR : positive -> RbaseSymbolsImpl.coq_R

val iZR : z -> RbaseSymbolsImpl.coq_R

val total_order_T :
  RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool option

val req_appart_dec : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool

val rrepr_appart_0 : RbaseSymbolsImpl.coq_R -> cReal_appart

module type RinvSig =
 sig
  val coq_Rinv : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R
 end

module RinvImpl :
 RinvSig

val rlt_dec : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool

val rle_dec : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> bool

val rmin :
  RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R

val rcase_abs : RbaseSymbolsImpl.coq_R -> bool

val rabs : RbaseSymbolsImpl.coq_R -> RbaseSymbolsImpl.coq_R

type spec_float =
| S754_zero of bool
| S754_infinity of bool
| S754_nan
| S754_finite of bool * positive * z

val sFcompare : spec_float -> spec_float -> comparison option

val cond_Zopp : bool -> z -> z

type radix = z
  (* singleton inductive, whose constructor was Build_radix *)

val radix_val : radix -> z

val radix2 : radix

val bpow : radix -> z -> RbaseSymbolsImpl.coq_R

type float = { fnum : z; fexp : z }

val f2R : radix -> float -> RbaseSymbolsImpl.coq_R

type binary_float =
| B754_zero of bool
| B754_infinity of bool
| B754_nan
| B754_finite of bool * positive * z

val b2SF : z -> z -> binary_float -> spec_float

val bcompare : z -> z -> binary_float -> binary_float -> comparison option

type binary_float0 =
| B754_zero0 of bool
| B754_infinity0 of bool
| B754_nan0 of bool * positive
| B754_finite0 of bool * positive * z

val b2BSN : z -> z -> binary_float0 -> binary_float

val b2R : z -> z -> binary_float0 -> RbaseSymbolsImpl.coq_R

val bcompare0 : z -> z -> binary_float0 -> binary_float0 -> comparison option

type float64 = binary_float0

type verifiedBoundary = { lower_rational : q; upper_rational : q;
                          lower_float : float64; upper_float : float64;
                          category : char list }

type verifiedDomain = { domain_name : char list;
                        measurement_unit : char list;
                        boundaries : verifiedBoundary list;
                        global_bounds : (float64 * float64);
                        domain_precision_bound : RbaseSymbolsImpl.coq_R }

val b2R64 : float64 -> RbaseSymbolsImpl.coq_R

val in_boundary_range : float64 -> verifiedBoundary -> bool

val find_category_flocq : verifiedBoundary list -> float64 -> char list option

val classify_flocq : verifiedDomain -> float64 -> char list

val boundary_distance_flocq :
  float64 -> verifiedBoundary -> RbaseSymbolsImpl.coq_R

val confidence_level_flocq : verifiedDomain -> float64 -> int
