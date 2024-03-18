#include <iostream>
#include <vector>
#include <string>

using namespace std;
struct IdInfo {
    string type;
    string name;
    int valI; 
    float valF;
    char valC;
    bool valB;
    string loc;
};

struct IdInfoArray{
    string type;
    string name;
    int size;
    string loc;
    int valI[100];
    float valF[100];
    char valC[100];
    bool valB[100];
};

struct IdInfoFunc{
    string type;
    string name;
    int size;
    string param; 
    string loc;
};

class IdList {
    vector<IdInfo> vars;
    vector<IdInfoArray> varsA;
    vector<IdInfoFunc> varsF;
    vector<string> varsC;
    vector<string> varsConst;
    vector<string> varsPriv;
    FILE* tabelfct;
    FILE* tabelval;

   
    public:
    bool existsVar(const char* s);
    bool existsVarFct(const char* s);
    bool existsVarCls(const char* s);
    bool existsVarArray(const char* s, int nr);

    void addVar(const char* type, const char* name , int valI, float valF, char valC, bool valB, string loc);
    int updateVar( const char* name, int valI, float valF, char valC, bool valB);
    void printVars();
    
    void addVarArray(const char* type, const char* name , int size, string loc);
    void printVarsArray();
    int updateVarArray( const char* name, int valI, float valF, char valC, bool valB, int nr); 
    
    void addVarFunc(const char* type, const char* name , int size, string param, string loc);
    string paramFct(const char* name );

    void addVarClasa(const char* name);
    void addVarConst(const char* name);
    void addVarPriv(const char* name);
    bool isConst(const char* name);
    bool isPriv(const char* name);
    void printPriv();
    
    
    string varType( const char* name);

    int returnValInt( const char* name  );
    float returnValFloat( const char* name  );
    char returnValChar( const char* name  );
    bool returnValBool( const char* name  );
    bool returnValBoolAr( const char* name, int nr  );
    int returnValIntAr( const char* name, int nr  );
    float returnValFloatAr( const char* name, int nr  );
    char returnValCharAr( const char* name, int nr  );
    
    void tabel_fct ();
    void clear_tablefct();
    void tabel_var ();
    void clear_tablevar();

    ~IdList();
};
/*
class IdListArray {
   
    public:
    bool existsVar(const char* s);
    ~IdListArray();
};*/






