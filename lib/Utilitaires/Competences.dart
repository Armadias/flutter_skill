import 'package:flutter/material.dart';

class Cours
{
  String nom;
  String description;

  List<Competences> comp = new List<Competences>();

  Cours(this.nom, this.description);
}

class Competences
{
  String description;

  bool validiteE;
  bool validiteP;

  int id;

  Competences(String description, int validiteEI, int validitePI, int id)
  {
    this.description = description;
    this.id = id;
    
    validiteEI == 0? validiteE = false : validiteE = true;
    validitePI == 0? validiteP = false : validiteP = true;
  }
}