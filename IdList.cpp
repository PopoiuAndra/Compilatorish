#include "IdList.h"
#include <cstring>
using namespace std;

void IdList::addVar(const char* type, const char*name, int valI, float valF, char valC, bool valB,  string loc) {
    IdInfo var = {string(type), string(name), valI, valF, valC, valB, loc};
    vars.push_back(var);
}

int IdList::updateVar(const char*name, int valI, float valF, char valC, bool valB) {
    for (int i = 0; i < vars.size();++i) {
        if(vars[i].name == name){
            if(vars[i].type == "int"){
                if(valI == -1) return 0;
                vars[i].valI = valI; 
            }
            else if(vars[i].type == "char"){
                if(valC == -1) return 0;
                vars[i].valC = valC; 
            }
            else if(vars[i].type == "float"){
                if(valF == -1) return 0;
                vars[i].valF = valF; 
            }
            else if(vars[i].type == "bool"){
                if(valB == -1) return 0;
                vars[i].valB = valB; 
            }
            return 1; // update facut cu succes
            }
     }
    return 0;
}

int IdList::updateVarArray( const char* name, int valI, float valF, char valC, bool valB, int nr){
    
    string strvar = string(name);
    for (int i = 0; i< varsA.size(); ++ i) {
        if(varsA[i].name == strvar)
        {
            if(varsA[i].type == "int"){
                if(valI == -1) return 0;
                varsA[i].valI[nr] = valI; 
            }
            else if(varsA[i].type == "char" || varsA[i].type == "string"){
                if(valC == -1) return 0;
                varsA[i].valC[nr] = valC;
            }
            else if(varsA[i].type == "float"){
                if(valF == -1) return 0;
                varsA[i].valF[nr] = valF; 
            }
            else{
                if(valB == -1) return 0;
                varsA[i].valB[nr] = valB; 
            }
            return 1; // update facut cu succes
        }
    }
    return 0;
}

void IdList::addVarArray(const char* type, const char*name, int size, string loc) {
    IdInfoArray var = {string(type), string(name), size, loc};
    varsA.push_back(var);
}

void IdList::addVarFunc(const char* type, const char*name, int size, string param, string loc) {
    IdInfoFunc var = {string(type), string(name), size, param, loc};
    varsF.push_back(var);
}

string IdList::paramFct(const char* var ){
    string strvar = string(var);
    for (const IdInfoFunc& v : varsF) {
        if (strvar == v.name) { 
            return v.param;
        }
    }
    return "";
}

void IdList::addVarClasa(const char* name){
    varsC.push_back(name);
}

void IdList::addVarConst(const char* name){
    varsConst.push_back(name);
}

void IdList::addVarPriv(const char* name){
    varsPriv.push_back(name);
}

bool IdList::isConst(const char* name){
    string strvar = string(name);
    for(int i = 0; i < varsConst.size(); ++ i)
        if(varsConst[i] == strvar)
            return true;
    return false;
}

bool IdList::isPriv(const char* name){
    string strvar = string(name);
    for(int i = 0; i < varsPriv.size(); ++ i)
        if(varsPriv[i] == strvar)
            return true;
    return false;
}

void IdList::printPriv(){

    for(int i = 0; i < varsPriv.size(); ++ i)
        std::cout << varsPriv[i] <<"\n";

}


bool IdList::existsVarCls(const char* var) {
    string strvar = string(var);
    for (const string& v : varsC) {
        if (strvar == v) { 
            return true;
        }
    }
    return false;
}

bool IdList::existsVarFct(const char* var) {
    string strvar = string(var);
    for (const IdInfoFunc& v : varsF) {
        if (strvar == v.name) { 
            return true;
        }
    }
    return false;
}

bool IdList::existsVarArray(const char* s, int nr) {
    string strvar = string(s);
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name && v.size >= nr) { 
            return true;
        }
    }
    return false;
}

bool IdList::existsVar(const char* var) {
    string strvar = string(var);
     for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return true;
        }
    }
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return true;
        }
    }
    for (const IdInfoFunc& v : varsF) {
        if (strvar == v.name) { 
            return true;
        }
    }
    for(const string &v: varsC){
        if(v == strvar){
            return true;
        }
    }
    return false;
}

void IdList::printVars() {
    for (const IdInfo& v : vars) {
        cout << "name: " << v.name << " type: " << v.type << " valoare int: " << v.valI << " valoare Float: " << v.valF << " valoare char: " << v.valC <<" valoare bool: " << v.valB << " locatie: " << v.loc<< endl; 
     }
}

void IdList::printVarsArray() {
    for (const IdInfoArray& v : varsA) {
        cout << "name: " << v.name << " type:" << v.type << " size: " << v.size << " locatie: " << v.loc << endl;
        for(int i = 0; i <= v.size; ++ i)
            cout << i <<": valI: " << v.valI[i] << " valF: " << v.valF[i]<< "valC: " << v.valC[i] << "valB: " << v.valB[i] << endl; 
     }
     cout << "FUNCTII: \n";
     for (const IdInfoFunc& v : varsF) {
        cout << "name: " << v.name << " type:" << v.type << " size: " << v.size<< "parametrii: " << v.param<<"\n";
    }

}

string IdList::varType(const char * name) {

    string strvar = string(name);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return v.type;
        }
    }
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return v.type;
        }
    }
    for (const IdInfoFunc& v : varsF) {
        if (strvar == v.name) { 
            return v.type;
        }
    }
    strvar="";
    return strvar;
}

int IdList::returnValInt( const char* name  )
{
    string strvar = string(name);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return v.valI;
        }
    }
    return 0;
}

float IdList::returnValFloat( const char* name  )
{
    string strvar = string(name);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return v.valF;
        }
    }
    return 0;
}

char IdList::returnValChar( const char* name  )
{
    string strvar = string(name);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return v.valC;
        }
    }
    return 0;
}

bool IdList::returnValBool( const char* name  )
{
    string strvar = string(name);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return v.valB;
        }
    }
    return 0;
}

bool IdList::returnValBoolAr( const char* name, int nr  )
{
    string strvar = string(name);
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return v.valB[nr];
        }
    }
    return 0;
}

int IdList::returnValIntAr( const char* name, int nr  )
{
    string strvar = string(name);
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return v.valI[nr];
        }
    }
    return 0;
}

float IdList::returnValFloatAr( const char* name, int nr  )
{
    string strvar = string(name);
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return v.valF[nr];
        }
    }
    return 0;
}

char IdList::returnValCharAr( const char* name, int nr  )
{
    string strvar = string(name);
    for (const IdInfoArray& v : varsA) {
        if (strvar == v.name) { 
            return v.valC[nr];
        }
    }
    return 0;
}

void IdList::tabel_var () {
    int i;
    tabelfct = fopen("symbol_table.txt", "a");
    for (const IdInfo& v : vars) {
        const char* str = v.name.c_str(); 
        const char* str2 = v.type.c_str(); 
        if(isConst(str))
            fprintf(tabelval, "Nume: %s | Tip: CONST %s | ", str, str2);
        else  fprintf(tabelval, "Nume: %s | Tip: %s | ", str, str2);
        
        //fprintf << "name: " <<  << " type: " <<  << " valoare int: " << v.valI << " valoare Float: " << v.valF << " valoare char: " << v.valC <<" valoare bool: " << v.valB << " locatie: " << v.loc<< endl; 
        string type = varType(str);
        if(type == "int"){
            fprintf(tabelval, "Valoare: %d | ", v.valI);
        }
        else if(type == "float"){
            fprintf(tabelval, "Valoare: %f | ", v.valF);
        }
        else if(type == "char"){
            fprintf(tabelval, "Valoare: %c | ", v.valC);
        }
        else if(type == "bool"){
            if(v.valB == 1)
                fprintf(tabelval, "Valoare: %s | ", "true");
            else fprintf(tabelval, "Valoare: %s | ", "false");
        }

        const char* str3 = v.loc.c_str(); 
        fprintf(tabelval, "Locatie: %s \n", str3);
     }
     for (const IdInfoArray& v : varsA) {
        const char* str = v.name.c_str(); 
        const char* str2 = v.type.c_str(); 
        fprintf(tabelval, "Nume: %s | Tip: %s %s | ", str, "Array", str2);
        //fprintf << "name: " <<  << " type: " <<  << " valoare int: " << v.valI << " valoare Float: " << v.valF << " valoare char: " << v.valC <<" valoare bool: " << v.valB << " locatie: " << v.loc<< endl; 
        string type = varType(str);
        fprintf(tabelval, "Valoare: ");
        if(type == "int"){

            for(int i = 0; i <= v.size; ++ i)
                fprintf(tabelval, "%d:%d ",i, v.valI[i]);
        }
        else if(type == "float"){
            for(int i = 0; i <= v.size; ++ i)
                fprintf(tabelval, "%d:%f ",i, v.valF[i]);
        }
        else if(type == "char"){
            for(int i = 0; i <= v.size; ++ i)
                fprintf(tabelval, "%d:%c ", i, v.valC[i]);
        }
        else if(type == "bool"){
            for(int i = 0; i <= v.size; ++ i)
                if(v.valB[i] == 1)
                    fprintf(tabelval, "%d,%s ", i, "true");
                else fprintf(tabelval, "%d:%s ", i, "false");
        }
        else if(type == "string"){
            for(int i = 0; i <= v.size; ++ i)
                fprintf(tabelval, "%d:%c ", i, v.valC[i]);
        }

        const char* str3 = v.loc.c_str(); 
        fprintf(tabelval, "| Locatie: %s \n", str3);
     }

}
void IdList::clear_tablefct(){

     tabelfct=fopen("symbol_table_functions.txt","w");
}

void IdList::tabel_fct () {
    int i;
   
     tabelfct = fopen("symbol_table_functions.txt", "a");
     for (const IdInfoFunc& v : varsF) {
        const char* str = v.name.c_str(); 
        const char* str2 = v.type.c_str(); 
        fprintf(tabelfct, "Nume: %s | Tip: %s | ", str, str2);
        fprintf(tabelfct, "Parametrii: ");
        
        string type = varType(str);
        for(int i = 1; i <= v.param.size(); ++i)
        if(v.param[i-1] == 'i'){
            fprintf(tabelfct, "%d:int ", i);
        }
        else if(v.param[i-1] == 'f'){
            fprintf(tabelfct, "%d:float ", i);
        }
        else if(v.param[i-1] == 'c'){
            fprintf(tabelfct, "%d:char ", i);
        }
        else if(v.param[i-1] == 'b'){
                fprintf(tabelfct, "%d:bool ", i);
        }

        const char* str3 = v.loc.c_str(); 
        fprintf(tabelfct, "| Locatie: %s \n", str3);
     }
}

void IdList::clear_tablevar(){

     tabelval=fopen("symbol_table.txt","w");
}

IdList::~IdList() {
    vars.clear();
}




