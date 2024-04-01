import { Response, Request } from 'express';
import { CustomError, PaginationDto, InscriptionDto } from '../../domain';
import { InscriptionService } from '../services';

export class InscriptionController {

  constructor(
    private readonly inscriptionService: InscriptionService,
  ) { }

  private handleError = (error: unknown, res: Response) => {
    if (error instanceof CustomError) {
      return res.status(error.statusCode).json({ error: error.message });
    }
    console.log(`${error}`);
    return res.status(500).json({ error: 'Internal server error' });
  };

  getInscriptions = async (req: Request, res: Response) => {
    const { page = 1, limit = 10 } = req.query;
    const [error, paginationDto] = PaginationDto.create(+page, +limit);
    if (error) return res.status(400).json({ error });

    this.inscriptionService.getInscriptions(paginationDto!)
      .then(inscriptions => res.json(inscriptions))
      .catch(error => this.handleError(error, res));
  };

  createInscription = (req: Request, res: Response) => {

    const [error, createInscriptionDto] = InscriptionDto.body(req.body);
    if (error) return res.status(400).json({ error });

    this.inscriptionService.createInscription(createInscriptionDto!, req.body.user)
      .then(inscription => res.status(201).json(inscription))
      .catch(error => this.handleError(error, res));

  };

  updateInscription = (req: Request, res: Response) => {

    const [error, updateInscriptionDto] = InscriptionDto.body(req.body);
    if (error) return res.status(400).json({ error });

    this.inscriptionService.updateInscription(updateInscriptionDto!, req.body.user, parseInt(req.params.id))
      .then(inscription => res.status(201).json(inscription))
      .catch(error => this.handleError(error, res));

  };

  deleteInscription = (req: Request, res: Response) => {

    this.inscriptionService.deleteInscription(req.body.user, parseInt(req.params.id))
      .then(inscription => res.status(201).json(inscription))
      .catch(error => this.handleError(error, res));

  };
}