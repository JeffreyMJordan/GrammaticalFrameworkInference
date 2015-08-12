--# -path=.:../lib/src/translator
--- a path to your GF/lib/src/translator

concrete InferenceEng of Inference = open (S=SyntaxEng), (G=GrammarEng), ParadigmsEng, 
(Ext=ExtensionsEng), 
IrregEng in {

lincat
  S=S.S ; Cl=S.Cl ; NP=S.NP ; VP=S.VP ; V=S.V ; VV=S.VV ; Pol=S.Pol ; Val=Str ; N = S.N ; Quant=S.Quant ; 
  Num=S.Num ; Predet=S.Predet ; Det=S.Det; CN=S.CN; V2=S.V2; VPSlash=S.VPSlash; V=S.V; Subj=S.Subj; Adv=S.Adv;
  A=S.A; AP=S.AP ; Comp=S.Comp ; Adv=S.Adv; AdV=S.AdV;
  
  RP=S.RP; RCl=S.RCl; RS=S.RS; Tense=S.Tense; Ant=S.Ant; Temp=S.Temp;

lin
  Pos = G.PPos ;
  Neg = G.PNeg ;
  --Null = G.PPos;
  
  TPres = G.TPres ;
  TPast = G.TPast ; 
  ASimul = G.ASimul ; 
  TTAnt = G.TTAnt ;
  
  IdRP = G.IdRP ;
  RelVP = G.RelVP ;
  UseRCl = G.UseRCl ;
  RelCN = G.RelCN ; 
  
  NumSg = G.NumSg ;
  NumPl = G.NumPl ;
  DefArt = G.DefArt ; 
  IndefArt = G.IndefArt ;
  no_Quant = G.no_Quant ;
  that_Quant = G.that_Quant ;
  all_Predet = G.all_Predet ;
  not_Predet = G.not_Predet ;
  someSg_Det = G.someSg_Det;
  every_Det = G.every_Det;
  many_Det = G.many_Det;
  few_Det = G.few_Det;
  that_Subj = G.that_Subj;
  
  PredetNP = G.PredetNP ;
  
  Plus, Minus, Neutral, MinusN, PlusN, NeutralM, NeutralP = [] ;
  UseCl p cl = S.mkS S.pastTense p cl ;
  PredVP = G.PredVP ;
  
  AdjCN = G.AdjCN ;
  
  
  ComplVV vv pol vp = Ext.ComplVV vv S.simultaneousAnt pol vp ;
  --ComplVV vv pol vp = Ext.ComplVV vv pol S.simultaneousAnt (S.mkVP plus_Adv vp) ;
  
  
  UseV = G.UseV ;
  UseN = G.UseN ;
  DetQuant = G.DetQuant ;
  DetCN = G.DetCN ;
  DetNP = G.DetNP ;
  PredetNP = G.PredetNP ;
  SlashV2a = G.SlashV2a ;
  ComplSlash = G.ComplSlash ;
  ApposCN = G.ApposCN ;
  AdvVP = G.AdvVP ; 
  SubjS = G.SubjS ;
  PositA = G.PositA ;
  CompAP = G.CompAP ;
  UseComp = G.UseComp ;
  ImpersCl =G.ImpersCl ;
  
  --AdvVP = G.AdvVP ;
  AdVVP = G.AdVVP ;
  PositAdvAdj = G.PositAdvAdj;
  CompCN = G.CompCN ;
  AdvNP = G.AdvNP ;
  AdvCN = G.AdvCN ;
  

  john_NP = S.mkNP (mkPN "John") ;
  sleep_V = IrregEng.sleep_V ;
  fail_VV = mkVV (mkV "fail") ;
  manage_VV = mkVV (mkV "manage") ;
  hesitate_VV = mkVV (mkV "hesitate");
  refuse_VV = mkVV (mkV "refuse");
  force_VV = mkVV (mkV "be forced" "be forced" "was forced" "forced" "forced");
  can_VV = mkVV (mkV "be able" "is able" "was able" "able" "is able");
  eat_V2 = mkV2 (mkV "eat" "ate" "eaten");
  like_V2 = mkV2 (mkV "like");
  love_V2 = mkV2 (mkV "love");
  think_V = mkV "think" "thought" "thought" ;
  girl_N = mkN "girl";
  cat_N = mkN "cat";
  dog_N = mkN "dog";
  mouse_N = mkN "mouse";
  pizza_N = mkN "pizza";
  good_A = mkA "good";
  true_A = mkA "true";
  
  plus_AdV = mkAdV ("+") ;
  minus_AdV = mkAdV ("-") ;
  neutral_AdV = mkAdV ("±");
  
  down_AdV = mkAdV ("(down)");
  up_AdV = mkAdV ("(up)");
  
  up_A = mkA "(up)";
  down_A = mkA "(down)";
}