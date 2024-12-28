#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <vector>
#include <bitset>
#include <string>

using namespace std;

// 預設符號表
unordered_map<string, int> SYMBOL_TABLE = {
    {"SP", 0}, {"LCL", 1}, {"ARG", 2}, {"THIS", 3}, {"THAT", 4}, {"R0", 0}, {"R1", 1}, {"R2", 2}, {"R3", 3}, {"R4", 4}, {"R5", 5}, {"R6", 6}, {"R7", 7}, {"R8", 8}, {"R9", 9}, {"R10", 10}, {"R11", 11}, {"R12", 12}, {"R13", 13}, {"R14", 14}, {"R15", 15}, {"SCREEN", 16384}, {"KBD", 24576}};

int nextVariableAddress = 16;

// C 指令的對應表
unordered_map<string, string> COMP_TABLE = {
    {"0", "0101010"}, {"1", "0111111"}, {"-1", "0111010"}, {"D", "0001100"}, {"A", "0110000"}, {"M", "1110000"}, {"!D", "0001101"}, {"!A", "0110001"}, {"!M", "1110001"}, {"-D", "0001111"}, {"-A", "0110011"}, {"-M", "1110011"}, {"D+1", "0011111"}, {"A+1", "0110111"}, {"M+1", "1110111"}, {"D-1", "0001110"}, {"A-1", "0110010"}, {"M-1", "1110010"}, {"D+A", "0000010"}, {"D+M", "1000010"}, {"D-A", "0010011"}, {"D-M", "1010011"}, {"A-D", "0000111"}, {"M-D", "1000111"}, {"D&A", "0000000"}, {"D&M", "1000000"}, {"D|A", "0010101"}, {"D|M", "1010101"}};

unordered_map<string, string> DEST_TABLE = {
    {"null", "000"}, {"M", "001"}, {"D", "010"}, {"MD", "011"}, {"A", "100"}, {"AM", "101"}, {"AD", "110"}, {"AMD", "111"}};

unordered_map<string, string> JUMP_TABLE = {
    {"null", "000"}, {"JGT", "001"}, {"JEQ", "010"}, {"JGE", "011"}, {"JLT", "100"}, {"JNE", "101"}, {"JLE", "110"}, {"JMP", "111"}};

// 移除空白行和註解
string cleanLine(const string &line)
{
    string clean = line.substr(0, line.find("//")); // 移除註解
    clean.erase(remove_if(clean.begin(), clean.end(), ::isspace), clean.end());
    return clean;
}

// 第一輪掃描：建立符號表
void firstPass(vector<string> &lines)
{
    int lineNumber = 0;
    for (const auto &line : lines)
    {
        if (line[0] == '(')
        { // 標籤符號
            string label = line.substr(1, line.find(')') - 1);
            SYMBOL_TABLE[label] = lineNumber;
        }
        else
        {
            lineNumber++;
        }
    }
}

// 翻譯 A 指令
string translateAInstruction(const string &symbol)
{
    int address;
    if (isdigit(symbol[0]))
    { // 如果是數字
        address = stoi(symbol);
    }
    else
    {
        if (SYMBOL_TABLE.find(symbol) == SYMBOL_TABLE.end())
        {
            SYMBOL_TABLE[symbol] = nextVariableAddress++;
        }
        address = SYMBOL_TABLE[symbol];
    }
    return bitset<16>(address).to_string();
}

// 翻譯 C 指令
string translateCInstruction(const string &instruction)
{
    string dest = "null", comp, jump = "null";
    size_t eqPos = instruction.find('=');
    size_t semicolonPos = instruction.find(';');

    if (eqPos != string::npos)
    {
        dest = instruction.substr(0, eqPos);
        comp = instruction.substr(eqPos + 1, semicolonPos - eqPos - 1);
    }
    else if (semicolonPos != string::npos)
    {
        comp = instruction.substr(0, semicolonPos);
        jump = instruction.substr(semicolonPos + 1);
    }
    else
    {
        comp = instruction;
    }

    return "111" + COMP_TABLE[comp] + DEST_TABLE[dest] + JUMP_TABLE[jump];
}

// 第二輪掃描：翻譯指令
vector<string> secondPass(vector<string> &lines)
{
    vector<string> binaryCode;
    for (const auto &line : lines)
    {
        if (line[0] == '@')
        { // A 指令
            string symbol = line.substr(1);
            binaryCode.push_back(translateAInstruction(symbol));
        }
        else if (line[0] != '(')
        { // C 指令
            binaryCode.push_back(translateCInstruction(line));
        }
    }
    return binaryCode;
}

// 主程式
int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        cerr << "Usage: assembler <input file>" << endl;
        return 1;
    }

    string inputFile = argv[1];
    string outputFile = inputFile.substr(0, inputFile.find_last_of('.')) + ".hack";

    ifstream infile(inputFile);
    ofstream outfile(outputFile);
    if (!infile.is_open() || !outfile.is_open())
    {
        cerr << "Error opening file!" << endl;
        return 1;
    }

    vector<string> lines;
    string line;
    while (getline(infile, line))
    {
        line = cleanLine(line);
        if (!line.empty())
        {
            lines.push_back(line);
        }
    }

    firstPass(lines);                              // 第一輪掃描
    vector<string> binaryCode = secondPass(lines); // 第二輪掃描

    for (const auto &binaryLine : binaryCode)
    {
        outfile << binaryLine << endl;
    }

    infile.close();
    outfile.close();

    cout << "Assembly completed. Output file: " << outputFile << endl;
    return 0;
}