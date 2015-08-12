abstract Inference = {

cat
  S ; Cl ; NP ; VP ; V ; VV ; Pol ; Val ; N ; Quant ; Num;  Predet ; Det ; CN ;
  V2 ; VPSlash ; RP ; RCl ; RS ; Tense ; Ant ; Temp ; Subj ; Adv ; A ; AP ; Comp ; AdV ; Adv;

data
  Pos, Neg, Null : Pol ;
  Plus, Minus, Neutral, MinusN, PlusN, NeutralM, NeutralP : Val;
  TPres, TPast : Tense;
  good_A, true_A: A;
  ASimul : Ant ;
  TTAnt : Tense -> Ant -> Temp;
  plus_AdV, minus_AdV, neutral_AdV, down_AdV, up_AdV : AdV;
  
  AdjCN : AP -> CN -> CN ;
  up_A, down_A : A ;
  
  
  PositAdvAdj : A -> Adv;
  AdVVP : AdV -> VP -> VP;
  AdvNP : NP -> Adv -> NP ;
  AdvCN : CN -> Adv -> CN ;
  
  
  
  
  
  no_inference : Cl;
  
  UseCl : Pol -> Cl -> S ;
  PredVP : NP -> VP -> Cl ;
  ComplVV : VV -> Pol -> VP -> VP ;
  
  
  UseV : V -> VP ;
  AdvVP : VP -> Adv -> VP;

  john_NP : NP ;
  
  girl_N, cat_N, dog_N, mouse_N, pizza_N : N ;
  think_V : V;
  eat_V2, like_V2, love_V2 : V2;
  SlashV2a : V2 -> VPSlash ;
  ComplSlash : VPSlash -> NP -> VP ;
  
  UseN : N -> CN ;
  someSg_Det, every_Det, many_Det, few_Det, somePl_Det : Det;
  that_Subj : Subj;
  SubjS : Subj -> S -> Adv ;
  
  DetCN : Det -> CN -> NP ;
  DetNP : Det -> NP ;
  
  
  IdRP : RP;
  RelVP : RP -> VP -> RCl;
  UseRCl : Temp -> Pol -> RCl -> RS;
  RelCN : CN -> RS -> CN ;
 
  ImpersCl : VP -> Cl;
  
  
  
  ApposCN : CN -> NP -> CN ;
  
  DefArt, IndefArt, no_Quant, that_Quant : Quant;
  NumSg, NumPl : Num ;
  DetQuant : Quant -> Num -> Det ;
  
  all_Predet, not_Predet : Predet;
  PredetNP : Predet -> NP -> NP ;
  
  sleep_V : V ;
  fail_VV, manage_VV, hesitate_VV, can_VV, 
  refuse_VV, force_VV : VV ;

  PositA : A -> AP;
  CompAP : AP -> Comp;
  UseComp : Comp -> VP;
  CompCN : CN -> Comp ; 
  
  

fun
  simplify : S -> S ;
def
  simplify (UseCl pol (PredVP np vp)) =
    useClVal (joinVal (valPol pol) (valVP vp)) (PredVP np (vpVP vp)) ;

fun
  vpVP : VP -> VP ;
def
  vpVP (ComplVV _ _ vp) = vpVP vp ;
  vpVP vp = vp ;

fun
  joinVal : Val -> Val -> Val ;
def
  joinVal Plus Plus = Plus ;
  joinVal Minus Minus = Plus ;
  joinVal _ Neutral = Neutral;
  
  joinVal Plus MinusN = MinusN;
  joinVal PlusN MinusN = MinusN;
  joinVal MinusN Minus = Plus ;
  joinVal MinusN _ = MinusN ;
  joinVal _ MinusN = Neutral;
  
  joinVal Plus PlusN = Plus;
  joinVal PlusN _ = PlusN;
  joinVal _ PlusN = Neutral;
  
  joinVal Minus NeutralM = MinusN;
  joinVal _ NeutralM = NeutralM;
  
  
  joinVal Minus NeutralP = Plus;
  joinVal _ NeutralP = NeutralP;
  
  joinVal Neutral _ = Neutral;
  joinVal NeutralP _ = NeutralP;
  joinVal NeutralM _ = NeutralM;
  
  
  joinVal Minus Plus = Minus ;
  joinVal Plus Minus = Minus;
fun
  valVP : VP -> Val ;
def
  valVP (ComplVV vv pol vp) = joinVal (valVV vv) (joinVal (valPol pol) (valVP vp)) ;
  valVP _ = Plus ;
  
fun
  valVV : VV -> Val ;
def
  valVV fail_VV = Minus ;
  valVV manage_VV = Plus ;
  valVV hesitate_VV = NeutralP;
  valVV can_VV = NeutralM;
  valVV refuse_VV = MinusN;
  valVV force_VV = PlusN;

fun
  valPol : Pol -> Val ;
def
  valPol Pos = Plus ;
  valPol Neg = Minus ;
  valPol Null = Neutral ;

fun
  useClVal : Val -> Cl -> S ;
def
  useClVal Plus cl = UseCl Pos cl ;
  useClVal Minus cl = UseCl Neg cl ;
  useClVal MinusN cl = UseCl Neg cl ;
  useclVal PlusN cl = UseCl Pos cl ;
  useClVal _ cl = UseCl Pos no_inference;
    
--fun
--  decorate : S -> S ;
--def
--  decorate (UseCl pol (PredVP np vp)) = 
    
  fun 
    copy : S -> S ;
  def
    copy (UseCl pol (PredVP np vp)) = 
      UseCl pol (PredVP (copyNP np) (copyVP vp));
    copy (UseCl pol (ImpersCl vp)) = 
      UseCl pol (ImpersCl (copyVP vp));
      
  fun 
    copyNP : NP -> NP ;
  def
    copyNP (DetCN det cn) = DetCN (copyDet det) (copyCN cn);
    copyNP (PredetNP predet np) = PredetNP (copyPredet predet) (copyNP np);
    copyNP np = np ;
    
  fun
    copyPredet : Predet -> Predet;
  def
    copyPredet predet = predet;  
  
  fun
    copyCN : CN -> CN ;
  def
    copyCN (UseN n) = UseN (copyN n);
    copyCN (ApposCN cn np) = ApposCN (copyCN cn) (copyNP np);
    
  fun
    copyDet : Det -> Det ;
  def
    copyDet (DetQuant quant num) = DetQuant (copyQuant quant) (copyNum num);
    copyDet det = det;
    
  fun 
    copyQuant : Quant -> Quant;
  def
    copyQuant quant = quant;
   
  fun
    copyNum : Num -> Num ;
  def
    copyNum num = num ;
    
  fun
    copyN : N -> N ;
  def 
    copyN n = n ;
    
  fun 
    copyVP : VP -> VP ;
  def 
    copyVP (ComplVV vv pol vp) = ComplVV vv pol (copyVP vp) ;
    copyVP (UseV v) = UseV (copyV v) ;
    copyVP (AdvVP vp adv) = AdvVP (copyVP vp) (copyAdv adv) ; 
    copyVP (UseComp comp) = UseComp (copyComp comp);
    copyVP (ComplSlash vpslash np) = ComplSlash (copyVPSlash vpslash) (copyNP np);
    
  fun
    copyVPSlash : VPSlash -> VPSlash;
  def
    copyVPSlash (SlashV2a v2) = SlashV2a (copyV2 v2);
    
  fun
    copyV2 : V2 ->V2 ;
  def
    copyV2 v2 = v2;
      
  fun
    copyComp : Comp -> Comp;
  def
    copyComp (CompAP ap) = CompAP (copyAP ap);
    
  fun
    copyAP : AP -> AP ;
  def
    copyAP (PositA a) = PositA (copyA a);
    
  fun
    copyA : A -> A ;
  def
    copyA a = a;
    
  fun
    copyV : V -> V ;
  def
    copyV v = v ;
    
  fun
    copyAdv : Adv -> Adv ; 
  def
    copyAdv (SubjS subj s) = SubjS (copySubj subj) (copy s);
    
  fun
    copySubj : Subj -> Subj ;
  def
    copySubj subj = subj ;
    
    
    
    
  fun
    decorate : S -> S;
  def
   decorate (UseCl pol (PredVP np vp)) = 
     UseCl pol (PredVP np (evalVP (valPol pol) vp));
     
  fun
    evalVP : Val -> VP -> VP ;
  def
   
    evalVP val (ComplVV vv pol vp) = 
    	ComplVV vv pol 
    		(AdVVP (evalAdV (joinVal val (valVV vv))) (evalVP (joinVal (valPol pol) (joinVal val (valVV vv))) vp) );
    	
    evalVP val vp = vp; 
    
    
  fun
    evalAdV : Val -> AdV ;
  def
    evalAdV Plus = plus_AdV;
    evalAdV Minus = minus_AdV;
    evalAdv Neutral = neutral_AdV;
    evalAdV MinusN = minus_AdV;
    evalAdV PlusN = plus_AdV;
    evalAdV NeutralM = neutral_AdV;
    evalAdV NeutralP = neutral_AdV;
    evalAdV _ = neutral_AdV;
    
  fun
    polVal : Val -> Pol ;
  def
    polVal Plus = Pos;
    polVal Minus = Neg;
    polVal PlusN = Pos;
    polVal MinusN = Neg;
    polVal _ = Pos;
    
    
    
  fun
    decorate2 : S -> S ;
  def
  	decorate2 (UseCl pol (PredVP (DetCN det cn) vp)) = 
    	UseCl pol (evalDetCNVP det cn vp);
  
    decorate2 (UseCl pol (PredVP np vp)) = 
    	UseCl pol (PredVP np (evalVP2 vp));
    	
    
    	
   fun
     evalDetCNVP : Det -> CN -> VP -> Cl ;
   def
     evalDetCNVP every_Det cn (UseComp (CompCN cn2))  = 
     	PredVP (DetCN every_Det (AdjCN (PositA down_A) cn)) (UseComp (CompCN (AdjCN (PositA up_A) cn2))) ;
     	
     evalDetCNVP some_Det cn (UseComp (CompCN cn2))  = 
     	PredVP (DetCN some_Det (AdjCN (PositA up_A) cn)) (UseComp (CompCN (AdjCN (PositA up_A) cn2))) ;
    	
      evalDetCNVP every_Det cn (ComplVV vv pol vp) = 
      	PredVP (DetCN every_Det (AdjCN (PositA down_A) (AdvCN cn (PositAdvAdj down_A)))) (evalVP2 (ComplVV vv pol vp)) ;
    	
      evalDetCNVP some_Det cn (ComplVV vv pol vp) = 
      	PredVP (DetCN some_Det (AdjCN (PositA up_A) (AdvCN cn (PositAdvAdj down_A)))) (evalVP2 (ComplVV vv pol vp)) ;
    	
    	
   fun
     evalVP2 : VP -> VP ;
   def
   
     evalVP2 (ComplVV vv pol vp) = 
     	ComplVV vv pol (evalVP2 vp) ;
     	
     evalVP2 (AdVVP adv (ComplVV vv pol vp)) = 
     	AdVVP adv (AdVVP down_AdV (ComplVV vv pol (evalVP2 vp))) ;
     	
     evalVP2 (AdVVP adv vp) =
     	evalMon adv vp ; 
     	
     
  	fun
  	  evalMon : AdV -> VP -> VP ; 
  	def
  	  evalMon minus_AdV (ComplSlash slash (DetCN every_Det cn)) = 
  	  	 AdVVP minus_AdV (ComplSlash slash (DetCN every_Det (AdjCN (PositA up_A) cn))) ;
  	  	 
  	  evalMon plus_AdV (ComplSlash slash (DetCN every_Det cn)) = 
  	  	 AdVVP plus_AdV (ComplSlash slash (DetCN every_Det (AdjCN (PositA down_A) cn))) ;
  	  	 
  	  evalMon minus_AdV (ComplSlash slash (DetCN some_Det cn)) = 
  	  	 AdVVP minus_AdV (ComplSlash slash (DetCN some_Det (AdjCN (PositA down_A) cn))) ;
  	  
  	  evalMon plus_AdV (ComplSlash slash (DetCN some_Det cn)) = 
  	  	 AdVVP plus_AdV (ComplSlash slash (DetCN some_Det (AdjCN (PositA up_A) cn))) ;
  	  	 
  	  evalMon adv (UseV v) = 
  	  	 AdVVP down_AdV (AdVVP adv (UseV v)) ;
  	  
  	  
  	
  	  
  	  
  	  
     

}