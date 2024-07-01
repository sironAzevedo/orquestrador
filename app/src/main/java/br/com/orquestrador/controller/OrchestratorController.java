package br.com.orquestrador.controller;

import br.com.orquestrador.model.ProductRequest;
import br.com.orquestrador.model.ProductResponse;
import br.com.orquestrador.service.OrchestratorService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/v1/orchestrator")
public class OrchestratorController {

	private final OrchestratorService service;

	@ResponseBody
	@PostMapping("/**")
	@Operation(summary = "Orchestrator")
	public ResponseEntity<ProductResponse> orchestrate(@RequestHeader("nome-produto") String nomeProduto,
													   @RequestHeader("token") String token,
													   @RequestHeader("correlation-id") String correlationId,
													   @RequestHeader("numero-conta") String numeroConta,
													   HttpServletRequest request) {
		String uri = request.getRequestURI();
		ProductRequest productRequest = new ProductRequest(nomeProduto, token, correlationId, numeroConta, uri);
		ProductResponse productResponse = service.orchestrate(productRequest);
		return ResponseEntity.ok(productResponse);
	}
}
