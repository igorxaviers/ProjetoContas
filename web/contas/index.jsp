<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    Usuario u = (Usuario) session.getAttribute("usuario");
    if(u == null)
        response.sendRedirect("/");
    else {
%>
<jsp:include page="../topo.jsp"/>
<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><i class="fas fa-dollar-sign"></i> Contas</h1>
    </div>
    <p class=" mt-2 mb-5">Gerenciamento das contas (Somente administradores podem aprovar)</p>

    <div class="mb-4 d-flex">
        <button class="btn btn-dark mr-3 px-4 bt-cad" onclick="contas.mostraForm('cadastrar')">
            <i class="fas fa-plus me-2"></i> Nova conta
        </button>
    </div>
    <form id="form-conta" class="card p-4 border-0 shadow  my-3 d-none">
        <div class="row justify-content-end">
            <button onclick="contas.fechar()" type="button" class="btn btn-danger" style="width: fit-content"><i class="fas fa-times"></i> Fechar</button>
        </div>
        <div class="row mb-4">
            <div class="col-6">
                <input type="hidden" value="" name="id-conta" id="id-conta">
                <input type="hidden" value="<%= u.getId() %>" name="id_usu" >

                <div class="row mb-3">
                    <div class="col-6" >
                        <label for="">Tipo da conta:</label>
                        <select name="tipo_conta" class="form-control" >
                            <option value="0">Pagar</option>
                            <option value="1">Receber</option>
                        </select>
                    </div>
                    <div class="col-6" id="status-conta">
                        <label for="">Status da conta:</label>
                        <% if(u.isAdmin()){%>
                        <select name="status" class="form-control">
                            <option value="Aprovado">Aprovado</option>
                            <option value="Reprovado">Reprovado</option>
                            <option value="Pendente">Pendente</option>
                        </select>
                        <%}else{%>
                        <input disabled name="status" value=""  class="form-control">
                        <%}%>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-12" >
                        <label for="">Fornecedor:</label>
                        <select name="fornecedor" class="form-control" id="fornecedores" required>
                            <option selected hidden disabled>-- Selecione um fornecedor --</option>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">
                        <label for="">Data:</label>
                        <input type="date" name="data" required>
                    </div>
                    <div class="col-6">
                        <label for="">Data vencimento:</label>
                        <input type="date" name="data_vencimento" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="nome" class="form-label">Descrição:</label>
                    <textarea type="text" class="form-control" name="descricao" placeholder="Descricao da conta" required minlength="1" maxlength="500" style="max-height: 250px; min-height: 150px;" required></textarea>
                </div>
                <div class="mb-3 row">
                    <div class="col-6">
                        <label for="valor" class="form-label">Valor:</label>
                        <input type="number" name="valor" class="form-control" placeholder="Valor da conta" min="0" required>
                    </div>
                    <div class="col-6">
                        <label for="nome" class="form-label">Usuário responsável:</label>
                        <input type="text" name="usu_id_usuarios" value="<%= u.getNome() %>" class="form-control" disabled>
                    </div>
                </div>
            </div>    
        </div>
        <button id="bt-alterar" onclick="contas.alterarConta()" type="button" class="btn btn-primary w-25">Alterar</button>
        <button id="bt-cadastrar" onclick="contas.cadastrarConta()" type="button" class="btn btn-primary w-25">Cadastrar</button>
    </form>

    <div class="card shadow border-0 mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <table class="table table-bordered dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                        <thead>
                            <tr role="row">
                                <th>Data</th>
                                <th>Data vencimento</th>
                                <th>Fornecedor</th>
                                <th>Responsável</th>
                                <th>Descrição</th>
                                <th>Status</th>
                                <th>Valor</th>
                                <th>Tipo</th>
                                
                                <th width="150px">Ações</th>
                            </tr>
                        </thead>
                        <tbody id="contas-table"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../js/contas/contas.js"></script>

<jsp:include page="../footer.jsp"/>
<% } %>  