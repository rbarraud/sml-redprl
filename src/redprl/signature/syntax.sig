signature ML_SYNTAX =
sig
  type id
  type metavariable
  type jdg
  type term

  type bindings = (metavariable * Tm.valence) list

  datatype value =
     (* thunk N *)
     THUNK of cmd

     (* x *)
   | VAR of id

     (* () *)
   | NIL

     (* [V1].V2 *)
   | ABS of value * value

     (* [X : v...] *)
   | METAS of bindings
  
     (* 'e *)
   | TERM of term

  and cmd =
     (* let x = M in N *)
     BIND of cmd * id * cmd
     
     (* ret V *)
   | RET of value

     (* force V *)
   | FORCE of value
  
     (* print V *)
   | PRINT of Pos.t option * value

     (* refine J e *)
   | REFINE of jdg * term

     (* ν [X : v...] in N *)
   | NU of bindings * cmd

     (* pm V as [Ψ].x in N *)
   | MATCH_ABS of value * id * id * cmd

     (* pm V as (x, y) in N *)
   | MATCH_THM of value * id * id * cmd

     (* abort *)
   | ABORT

  (* TODO: pretty printer *)
end