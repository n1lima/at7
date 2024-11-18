module morse (
    in, out, reset, clk
);
    input in, reset, clk;
    output reg [7:0] out;

    parameter IDLE = 5'bxxxxx, E = 5'b00000, A = 5'b00001, T = 5'b00010, I = 5'b00100, S = 5'b00101, U = 5'b00110, N = 5'b01000, M = 5'b01001, G = 5'b01010, O = 5'b01100;
    reg [5:0] state, next_state;

    // Lógica Sequencial    
    always @(posedge clk) begin
        if (reset)
            state = IDLE;
        else
            state = next_state;        
    end
    
    // Lógica Combinacional de entrada
    always @(*) begin
        case (state)   // 1 -> ponto 0 -> traço
            IDLE: begin
                if (in)
                    next_state = E; // .
                else
                    next_state = T; // -
            end   
            E: begin
                if (in)
                    next_state = I; // ..
                else
                    next_state = A; // .-
            end  
            I: begin
                if(in)
                    next_state = S;
                else
                    next_state = U;
            end   
            T: begin
                if(in)
                    next_state = N;
                else
                    next_state = M;
            end   
            M: begin
                if(in)
                    next_state = G;
                else
                    next_state = O;
            end             
            default: next_state = IDLE;
        endcase
        
    end

    // Lógica Combinacional de saída
    always @(*) begin
        case (state)
            IDLE: out = 8'h00;
            E: out = 8'h45;
            T: out = 8'h54;
            A: out = 8'h42;
            I: out = 8'h49;  
            S: out = 8'h53;
            U: out = 8'h55;    
            N: out = 8'h4E;
            M: out = 8'h4D;
            G: out = 8'h47;
            O: out = 8'h4F;
            default: next_state = IDLE;
        endcase
    end
endmodule